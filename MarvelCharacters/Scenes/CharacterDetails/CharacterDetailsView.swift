//
//  CharacterDetailsView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CharacterDetailsViewDelegate: AnyObject {
    func setFavorite(_ view: CharacterDetailsView, value: Bool)
}

final class CharacterDetailsView: UIScrollView {
    
    var contentView = UIView()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var detailsContentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.light
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.darkGray
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()
    
    lazy var comicsView: CarouselView = {
        let view = CarouselView()
        view.titleLabel.text = Strings.comics.localizable.uppercased()
        return view
    }()
    
    lazy var seriesView: CarouselView = {
        let view = CarouselView()
        view.titleLabel.text = Strings.series.localizable.uppercased()
        return view
    }()
    
    lazy var favoriteView: StarView = {
        let view = StarView()
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.imageView?.contentMode = .scaleToFill
        view.contentHorizontalAlignment = .fill
        view.contentVerticalAlignment = .fill
        return view
    }()

    weak var customDelegate: CharacterDetailsViewDelegate?

    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        contentSize = contentView.frame.size
    }
}

// MARK: View Code Protocol
extension CharacterDetailsView: ViewCode {
    
    func setupHierarchy() {
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(detailsContentView)
        contentView.addSubview(favoriteView)
        detailsContentView.addSubview(descriptionLabel)
        detailsContentView.addSubview(comicsView)
        detailsContentView.addSubview(seriesView)
    }
    
    func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        detailsContentView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsView.translatesAutoresizingMaskIntoConstraints = false
        seriesView.translatesAutoresizingMaskIntoConstraints = false
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5).isActive = true
        
        detailsContentView.topAnchor.constraint(equalTo: topAnchor, constant: 400).isActive = true
        detailsContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        detailsContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        detailsContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        favoriteView.centerYAnchor.constraint(equalTo: detailsContentView.topAnchor).isActive = true
        favoriteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        favoriteView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        favoriteView.heightAnchor.constraint(equalTo: favoriteView.widthAnchor).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: favoriteView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: detailsContentView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: detailsContentView.trailingAnchor, constant: -20).isActive = true
        
        comicsView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        comicsView.leadingAnchor.constraint(equalTo: detailsContentView.leadingAnchor).isActive = true
        comicsView.trailingAnchor.constraint(equalTo: detailsContentView.trailingAnchor).isActive = true
        comicsView.heightAnchor.constraint(equalToConstant: 250).isActive = true

        seriesView.topAnchor.constraint(equalTo: comicsView.bottomAnchor, constant: 10).isActive = true
        seriesView.leadingAnchor.constraint(equalTo: detailsContentView.leadingAnchor).isActive = true
        seriesView.trailingAnchor.constraint(equalTo: detailsContentView.trailingAnchor).isActive = true
        seriesView.bottomAnchor.constraint(equalTo: detailsContentView.bottomAnchor, constant: -20).isActive = true
        seriesView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func setupConfigurations() {
        favoriteView.addTarget(self, action: #selector(onStarButtonClick), for: .touchUpInside)
        descriptionLabel.numberOfLines = 0
        backgroundColor = UIColor.light
    }
}

private extension CharacterDetailsView {
    
    @objc func onStarButtonClick(_ sender: StarView) -> Void {
        sender.toogleFill()
        customDelegate?.setFavorite(self, value: sender.isFilled)
    }
}

