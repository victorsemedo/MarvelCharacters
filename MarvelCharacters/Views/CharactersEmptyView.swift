//
//  CharactersEmptyView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 17/01/21.
//

import UIKit

enum CharactersEmptyType {
    case apiError
    case internetConnection
    case emptyFavorites
    
    var imageName: String {
        switch self {
        case .apiError:
            return "hydra_marvel"
        case .internetConnection:
            return "signal_wifi_off"
        case .emptyFavorites:
            return "stars"
        }
    }
    
    var message: String {
        switch self {
        case .apiError:
            return Strings.errorUnknown.localizable
        case .internetConnection:
            return Strings.errorNoConnection.localizable
        case .emptyFavorites:
            return Strings.noFavorites.localizable
        }
    }
}

final class CharactersEmptyView : UIView {
    
    private var emptyImage: String? = nil {
        didSet {
            guard let emptyImage = emptyImage else {
                imageView.image = nil
                return
            }
            imageView.rederize(image: emptyImage, color: .captainCelticBlue)
        }
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textColor = UIColor.darkGray
        view.numberOfLines = 0
        return view
    }()
    
    var type = CharactersEmptyType.apiError {
        didSet {
            setupConfigurations()
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

extension CharactersEmptyView: ViewCode {
    
    func setupHierarchy() {
        addSubview(imageView)
        addSubview(label)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupConfigurations() {
        imageView.rederize(image: type.imageName, color: .captainCelticBlue)
        label.text = type.message
    }
    
}
