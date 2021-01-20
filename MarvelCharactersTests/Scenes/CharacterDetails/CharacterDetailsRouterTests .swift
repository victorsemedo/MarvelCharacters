//
//  CharacterDetailsRouterTests .swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharacterDetailsRouterTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharacterDetailsRouter!
    var dataStoreSpy: CharacterDetailsInteractorSpy!
    var viewControllerSpy: CharacterDetailsViewControllerSpy!
    var navigationControllerSpy: UINavigationControllerSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        dataStoreSpy = CharacterDetailsInteractorSpy()
        viewControllerSpy = CharacterDetailsViewControllerSpy()
        navigationControllerSpy = UINavigationControllerSpy(rootViewController: viewControllerSpy)
        
        sut = CharacterDetailsRouter.init(viewController: viewControllerSpy,
                                          dataStore: dataStoreSpy)
    }
    
    override func tearDown() {
        dataStoreSpy = nil
        viewControllerSpy = nil
        sut = nil
        navigationControllerSpy = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testRouteToSomewhere() {
    }
}
