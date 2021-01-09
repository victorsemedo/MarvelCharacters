//
//  CharactersView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

class CharactersView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World!"
        return label
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
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
    }
    
    func setupConfigurations() {
        backgroundColor = UIColor.white
    }
}
