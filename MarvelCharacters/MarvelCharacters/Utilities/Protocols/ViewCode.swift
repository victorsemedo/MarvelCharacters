//
//  ViewCode.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import Foundation

protocol ViewCode {
    
    func setupHierarchy()
    
    func setupConstraints()
    
    func setupConfigurations()
}

extension ViewCode {
    
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }

    func setupConfigurations() { /*Default implementation*/ }
}
