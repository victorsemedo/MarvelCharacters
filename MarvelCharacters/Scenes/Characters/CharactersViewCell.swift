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
        let label = UILabel()
        return label
    }()
    
    lazy var starView: StarView = {
        let label = StarView()
        return label
    }()
    
    weak var delegate: CharacterViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

extension CharactersViewCell: ViewCode {
    
    func setupHierarchy() {
        addSubview(imageView)
        addSubview(label)
        addSubview(starView)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        starView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        starView.heightAnchor.constraint(equalTo: starView.widthAnchor, multiplier: 1.0).isActive = true
        starView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starView.centerYAnchor.constraint(equalTo: label.topAnchor).isActive = true
        starView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func setupConfigurations() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1.0

        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        starView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        starView.imageView?.contentMode = .scaleToFill
        starView.contentHorizontalAlignment = .fill
        starView.contentVerticalAlignment = .fill
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect:bounds, cornerRadius:contentView.layer.cornerRadius).cgPath
    }
}
