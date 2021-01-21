//
//  UIView+ViewCode.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 21/01/21.
//

import UIKit

public extension UIView {
    /**
     * The `addSubview<T: UIView>(_ view: T, affectedViews: [T] = [], constraints: [NSLayoutConstraint])`
     * function adds a view with custom constraints.
     */
    func addSubview<T: UIView>(_ view: T, affectedViews: [T] = [], constraints: [NSLayoutConstraint]) {
        addSubview(view, affectedViews: affectedViews)

        NSLayoutConstraint.activate(constraints)
    }

    func addSubview<T: UIView>(_ view: T, affectedViews: [T] = [], _ viewBuilder: (T) -> Void) {
        addSubview(view, affectedViews: affectedViews)

        viewBuilder(view)
    }

    /**
     * The `addSubview<T: UIView>(equalConstraintsFor view: T, affectedViews: [T] = [])`
     * function adds a view with all constraints equals to another view.
     */
    func addITISubview<T: UIView>(equalConstraintsFor view: T, affectedViews: [T] = []) {
        addSubview(view, affectedViews: affectedViews)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func addSubview<T: UIView>(_ view: T, autoresizingMask: UIView.AutoresizingMask) {
        addSubview(view)

        view.autoresizingMask = autoresizingMask
    }
    
    func getHeightConstraint() -> NSLayoutConstraint? {
        return constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal })
    }
    
    func setHeightConstraint(_ constant: CGFloat) {
        guard let heightConstraint = getHeightConstraint() else {
            translatesAutoresizingMaskIntoConstraints = false
            let heightConstraint = heightAnchor.constraint(equalToConstant: constant)
            heightConstraint.isActive = true
            return
        }
        
        heightConstraint.constant = constant
    }
    
    func getWidthConstraint() -> NSLayoutConstraint? {
        return constraints.first(where: { $0.firstAttribute == .width && $0.relation == .equal })
    }
    
    func setWidthConstraint(_ constant: CGFloat) {
        guard let widthConstraint = getWidthConstraint() else {
            translatesAutoresizingMaskIntoConstraints = false
            let widthConstraint = widthAnchor.constraint(equalToConstant: constant)
            widthConstraint.isActive = true
            return
        }
        
        widthConstraint.constant = constant
    }
    
}

// MARK: Private functions
private extension UIView {

    func addSubview<T: UIView>(_ view: T, affectedViews: [T]) {
        addSubview(view)

        [affectedViews + [view]].flatMap(Set.init).forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
