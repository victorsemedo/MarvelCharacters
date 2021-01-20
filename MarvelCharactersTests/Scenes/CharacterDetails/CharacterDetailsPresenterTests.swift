//
//  CharacterDetailsPresenterTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharacterDetailsPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharacterDetailsPresenter!
    var viewControllerSpy: CharacterDetailsViewControllerSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        viewControllerSpy = CharacterDetailsViewControllerSpy()
        sut = CharacterDetailsPresenter(viewController: viewControllerSpy)
    }
    
    override func tearDown() {
        viewControllerSpy = nil
        super.tearDown()
    }

}
