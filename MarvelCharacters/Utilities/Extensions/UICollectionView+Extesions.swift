//
//  UICollectionView+Extesions.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 17/01/21.
//

import UIKit

extension UICollectionView {

    func setEmptyView(_ view: UIView) {
        self.backgroundView = view;
    }

    func restore() {
        self.backgroundView = nil
    }
}

