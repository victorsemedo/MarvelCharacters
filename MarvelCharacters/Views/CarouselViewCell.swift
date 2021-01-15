//
//  CarouselViewCellCollectionViewCell.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

final class CarouselViewCell: UICollectionViewCell {
    
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
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.color = UIColor.white
        return view
    }()
        
    var viewModel: CarouselCellProtocol? {
        didSet {
            label.text = viewModel?.name?.uppercased()
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

private extension CarouselViewCell {
    
    @objc func onStarButtonClick(_ sender: StarView) -> Void {
        sender.toogleFill()
    }
}

extension CarouselViewCell: ViewCode {
    
    func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(loadingIndicator)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        loadingIndicator.heightAnchor.constraint(equalToConstant: 24).isActive = true
        loadingIndicator.widthAnchor.constraint(equalTo: loadingIndicator.heightAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupConfigurations() {
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
