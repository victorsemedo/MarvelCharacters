//
//  CharactersView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersCellProtocol {
    var name: String? { get }
    var imageUrl: String? { get }
    var image: UIImage? { get }
    var isFavorite: Bool { get set}
}

protocol CharactersViewDelegate: AnyObject {
    func willDisplayLastCell(_ view: CharactersView)
    func didUpdateSearchBar(_ view: CharactersView)
    func didUpdateFavorite(_ view: CharactersView, forIndexPath indexPath: IndexPath, withValue value: Bool)
    func didSelectItemAt(_ view: CharactersView, forIndexPath indexPath: IndexPath)
    func didPullToRefresh(_ view: CharactersView)
}

extension CharactersViewDelegate {
    func willDisplayLastCell(_ view: CharactersView) { }
}

final class CharactersView: UIView {
    
    struct ViewModel {
        let cells:[CharactersCellProtocol]
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = UIColor.captainCelticBlue
        return view
    }()

    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = Strings.searchByName.localizable
        view.delegate = self
        view.tintColor = UIColor.captainCelticBlue
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 200)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CharactersViewCell.self, forCellWithReuseIdentifier: String(describing: CharactersViewCell.self))
        return view
    }()
    
    var viewModel: CharactersView.ViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: CharactersViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CharactersView {
    
    @objc private func didPullToRefresh(_ sender: Any) {
        delegate?.didPullToRefresh(self)
    }
}

// MARK: View Code Protocol
extension CharactersView: ViewCode {
    
    func setupHierarchy() {
        addSubview(collectionView)
        addSubview(searchBar)
        collectionView.refreshControl = refreshControl
    }
    
    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    func setupConfigurations() {
        backgroundColor = UIColor.light
        searchBar.barTintColor = UIColor.light
        searchBar.layer.borderWidth = 1;
        searchBar.layer.borderColor = UIColor.light.cgColor
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        collectionView.backgroundColor = UIColor.light
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CharactersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cells.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharactersViewCell.self), for: indexPath) as? CharactersViewCell) ??
            CharactersViewCell()
        cell.delegate = self
        
        if let cells = self.viewModel?.cells {
            cell.viewModel = cells[indexPath.row]
        }
        
        return cell
    }
}

extension CharactersView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(self, forIndexPath: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - frame.size.height
        
        if currentPosition > 0 && currentPosition >= contentHeight {
            delegate?.willDisplayLastCell(self)
        }
    }
}

extension CharactersView: UICollectionViewDelegateFlowLayout {
    
    private var margin: CGFloat { return 16.0 }
    
    private var insetForSections: UIEdgeInsets {
        UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = insetForSections.left + insetForSections.right + margin
        var width = (bounds.size.width - padding)/2 - margin/2
        width = width > 200 ? 200 : width
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}

extension CharactersView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(CharactersView.didUpdateSearchBar), object: nil)
        perform(#selector(CharactersView.didUpdateSearchBar), with: nil, afterDelay: 0.5)
    }
    
    @objc func didUpdateSearchBar() {
        guard searchBar.text != nil else { return }
        delegate?.didUpdateSearchBar(self)
    }
}

extension CharactersView: CharacterViewCellDelegate {
    
    func setFavorite(_ cell: CharactersViewCell, value: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        delegate?.didUpdateFavorite(self, forIndexPath: indexPath, withValue: cell.favoriteView.isFilled)
    }
}
