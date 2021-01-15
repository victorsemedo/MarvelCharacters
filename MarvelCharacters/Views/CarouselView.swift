//
//  CarouselView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CarouselCellProtocol {
    var name: String? { get }
    var imageUrl: String? { get }
    var image: UIImage? { get }
}

final class CarouselView: UIView {
    
    // MARK: - IBOulets
    
    struct ViewModel {
        let cells: [CarouselCellProtocol]
    }
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.tintColor = UIColor.captainCelticBlue
        view.font = UIFont.marvelFont(withSize: 24)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 100)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CharactersViewCell.self, forCellWithReuseIdentifier: String(describing: CharactersViewCell.self))
        return view
    }()
                
    // MARK: - Private Properties
    
    var viewModel: CarouselView.ViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
        let identifier = String(describing: CharactersViewCell.self)
        
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
        return CGSize(width: 50, height: 100)
    }
}
