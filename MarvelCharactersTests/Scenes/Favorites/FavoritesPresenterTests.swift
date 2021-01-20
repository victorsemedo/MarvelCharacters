//
//  FavoritesPresenterTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class FavoritesPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: FavoritesPresenter!
    var viewControllerSpy: FavoritesViewControllerSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        viewControllerSpy = FavoritesViewControllerSpy()
        sut = FavoritesPresenter(viewController: viewControllerSpy)
    }
    
    override func tearDown() {
        viewControllerSpy = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testPresentSomething() {
    }
}
