//
//  CharactersPresenterTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharactersPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersPresenter!
    var viewControllerSpy: CharactersViewControllerSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        viewControllerSpy = CharactersViewControllerSpy()
        sut = CharactersPresenter(viewController: viewControllerSpy)
    }
    
    override func tearDown() {
        viewControllerSpy = nil
        super.tearDown()
    }

}
