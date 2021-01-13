//
//  StarView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 11/01/21.
//

import UIKit

final class StarView: UIButton {

    // MARK: - Public Properties
    var isFilled: Bool = false {
        didSet {
            animate()
        }
    }
    
    // MARK: - Private Properties
    private var imageScale: CGFloat = 0.8
    
    private var starImage: UIImage? = UIImage(named: "star_outline")
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
}

// MARK: - Public Functions
extension StarView {
    func toogleFill() {
        isFilled = !isFilled
    }
}

// MARK: - Private Functions
private extension StarView {
  
    func setupView() {
        setupImage()
        setTitle(nil, for: .normal)
        setImage(starImage, for: .normal)
    }
    
    func setupImage() {
        imageScale = isFilled
            ? CGFloat(1.5)
            : CGFloat(0.8)
        starImage = isFilled
            ? UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
            : UIImage(named: "star_outline")?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = UIColor.orangeLight
        starImage?.withRenderingMode(.alwaysOriginal)
    }
    
    func animate() {
        UIView.animate(
            withDuration: 0.1,
            animations: {
                self.setupView()
                self.transform = self.transform.scaledBy(
                    x: self.imageScale, y: self.imageScale)
            },
            completion: { [weak self] _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self?.transform = CGAffineTransform.identity
                })
        })
    }
}

