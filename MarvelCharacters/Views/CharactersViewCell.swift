//
//  CharactersViewCell.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import UIKit

protocol CharacterViewCellDelegate: AnyObject {
    func setFavorite(_ cell: CharactersViewCell, value: Bool)
}

class CharactersViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = PaddingLabel()
        label.backgroundColor = .captainCelticBlue
        label.textColor = .white
        label.font = UIFont.marvelFont(withSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var favoriteView: StarView = {
        let view = StarView()
        return view
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.color = UIColor.white
        return view
    }()
    
    weak var delegate: CharacterViewCellDelegate?
    
    var viewModel: CharactersCellProtocol? {
        didSet {
            label.text = viewModel?.name?.uppercased()
            favoriteView.isFilled = viewModel?.isFavorite ?? false
            if let image = viewModel?.image {
                imageView.image = image
            } else if let imageUrl = viewModel?.imageUrl {
                loadingIndicator.startAnimating()
                imageView.loadImage(fromUrl: imageUrl) {
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CharactersViewCell {
    
    @objc func onStarButtonClick(_ sender: StarView) -> Void {
        sender.toogleFill()
        delegate?.setFavorite(self, value: sender.isFilled)
    }
}

extension CharactersViewCell: ViewCode {
    
    func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(favoriteView)
        contentView.addSubview(loadingIndicator)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: favoriteView.leadingAnchor).isActive = true
        
        favoriteView.heightAnchor.constraint(equalTo: favoriteView.widthAnchor, multiplier: 1.0).isActive = true
        favoriteView.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 0.7).isActive = true
        favoriteView.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        favoriteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        loadingIndicator.heightAnchor.constraint(equalToConstant: 24).isActive = true
        loadingIndicator.widthAnchor.constraint(equalTo: loadingIndicator.heightAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupConfigurations() {
        favoriteView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        favoriteView.imageView?.contentMode = .scaleToFill
        favoriteView.contentHorizontalAlignment = .fill
        favoriteView.contentVerticalAlignment = .fill
        favoriteView.addTarget(self, action: #selector(onStarButtonClick), for: .touchUpInside)
        contentView.backgroundColor = UIColor.primaryRed
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.primaryRed.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}

