//
//  UIImageView+Extension.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 12/01/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(fromUrl url: String, completion: (() -> Void)? = nil) {
        kf.setImage(
            with: URL(string: url),
            options: [.transition(.fade(0.3))],
            completionHandler: { _ in
                completion?()
            })
    }
    
    func cancel() {
        kf.cancelDownloadTask()
    }
}

