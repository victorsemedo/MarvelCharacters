//
//  CarouselView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CarouselCellProtocol {
    var title: String? { get }
    var imageUrl: String? { get }
    var image: UIImage? { get set}
}

final class CarouselView: UIView {
    
    // MARK: - IBOulets
    
    struct ViewModel {
        let cells: [CarouselCellProtocol]
    }
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.captainCelticBlue
        view.font = UIFont.marvelFont(withSize: 24)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 100)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CarouselViewCell.self, forCellWithReuseIdentifier: String(describing: CarouselViewCell.self))
        return view
    }()
                
    // MARK: - Private Properties
    
    var viewModel: CarouselView.ViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - View Lifecycle
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarouselView: ViewCode {
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    func setupConfigurations() {
        backgroundColor = UIColor.light
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.light
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - UICollectionView Protocol Extensions
extension CarouselView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cells.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: CarouselViewCell.self)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CarouselViewCell else {
            return CarouselViewCell()
        }
        
        if let cells = self.viewModel?.cells {
            cell.viewModel = cells[indexPath.row]
        }
        
        return cell
    }
}

extension CarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.height*0.5, height: frame.height - 60)
    }
}
