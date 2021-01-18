//
//  CarouselEmptyView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 17/01/21.
//

import UIKit

final class CarouselEmptyView : UIView {
    
    var label = UILabel()
        
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

extension CarouselEmptyView: ViewCode {
    
    func setupHierarchy() {
        addSubview(label)
    }
    
    func setupConstraints() {
        label.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupConfigurations() {
        label.textAlignment = .center
        label.text = "teste"
    }
    
}
