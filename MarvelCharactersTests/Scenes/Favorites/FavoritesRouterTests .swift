//
//  FavoritesRouterTests .swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class FavoritesRouterTests: XCTestCase {
    // MARK: Subject under test
    var sut: FavoritesRouter!
    var dataStoreSpy: FavoritesInteractorSpy!
    var viewControllerSpy: FavoritesViewControllerSpy!
    var navigationControllerSpy: UINavigationControllerSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        dataStoreSpy = FavoritesInteractorSpy()
        viewControllerSpy = FavoritesViewControllerSpy()
        navigationControllerSpy = UINavigationControllerSpy(rootViewController: viewControllerSpy)
        sut = FavoritesRouter(viewController: viewControllerSpy, dataStore: dataStoreSpy)
    }
    
    override func tearDown() {
        dataStoreSpy = nil
        viewControllerSpy = nil
        navigationControllerSpy = nil
        sut = nil
        super.tearDown()
    }

}
