//
//  UIViewControllerSpy.swift
//  MarvelCharactersTests
//
//  Created by Victor Tavares on 19/01/21.
//

import UIKit

class UIViewControllerSpy: UIViewController {

    var presentViewControllerCalled = false
    
    var viewControllerToPresent: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentViewControllerCalled = true
        self.viewControllerToPresent = viewControllerToPresent
    }
}
