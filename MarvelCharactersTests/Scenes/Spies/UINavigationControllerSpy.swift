//
//  UINavigationControllerSpy.swift
//  MarvelCharactersTests
//
//  Created by Victor Tavares on 19/01/21.
//

import UIKit

class UINavigationControllerSpy: UINavigationController {

    var pushViewControllerCalled = false
    
    var pushViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCalled = true
        pushViewController = viewController
    }
}
