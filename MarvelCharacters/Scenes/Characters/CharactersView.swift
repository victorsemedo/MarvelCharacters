//
//  CharactersView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

class CharactersView: UIView {
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
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
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: View Code Protocol
extension CharactersView: ViewCode {
    func setupHierarchy() {
        addSubview(collectionView)
        addSubview(searchBar)
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
        collectionView.backgroundColor = UIColor.light
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CharactersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharactersViewCell.self), for: indexPath)
        cell.backgroundColor = UIColor.redLight
        
        return cell
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
        let width = (bounds.size.width - padding)/2 - margin/2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}

