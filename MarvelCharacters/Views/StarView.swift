//
//  StarView.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 11/01/21.
//

import UIKit

class StarView: UIButton {

    // MARK: - Public Properties
    
    @IBInspectable var isFilled: Bool = false {
        didSet {
            animate()
        }
    }
    
    // MARK: - Private Properties
    
    private var imageScale: CGFloat = 0.7
    
    private var starImage: UIImage? = UIImage(named: "star_outline")
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    // MARK: - Public Functions
    
    func toggleIt() {
        isFilled = !isFilled
    }
}

private extension StarView {
  
    func setupView() {
        setupImage()
        setTitle(nil, for: .normal)
        setImage(starImage, for: .normal)
    }
    
    private func setupImage() {
        imageScale = isFilled
            ? CGFloat(1.3)
            : CGFloat(0.7)
        
        starImage = isFilled
            ? UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
            : UIImage(named: "star_outline")?.withRenderingMode(.alwaysTemplate)
        
        imageView?.tintColor = UIColor.orangeLight
        starImage?.withRenderingMode(.alwaysOriginal)
    }
    
    private func animate() {
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

