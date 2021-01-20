//
//  CharactersViewControllerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharactersViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersViewController!
    var interactorSpy: CharactersInteractorSpy!
    var routerSpy: CharactersRouterSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        interactorSpy = CharactersInteractorSpy()
        routerSpy = CharactersRouterSpy()
        sut = CharactersViewController()
        sut.setup(interactor: interactorSpy, router: routerSpy)
        _ = sut.view
    }
    
    override func tearDown() {
        interactorSpy = nil
        routerSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testloadView() {
        if let view = sut.view as? CharactersView {
            XCTAssertNotNil(view.delegate)
            XCTAssertNotNil(view.collectionView.delegate)
            XCTAssertNotNil(view.collectionView.dataSource)
            XCTAssertEqual(sut.title, Strings.characters.localizable.uppercased())
        } else {
            XCTFail()
        }
    }
    
    func testloadNextPage() {
        XCTAssertTrue(interactorSpy.loadNextPageCalled)
        XCTAssertFalse(interactorSpy.reloadFavoritesCalled)
    }
    
    func testDisplayLoadNextPage() {
        let view = sut.view as? CharactersView
        sut.displayLoadNextPage(viewModel: CharactersSeeds.loadNextPageViewModel)
        let rows = view?.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(rows, 20)
        
        if let collection = view?.collectionView {
            let cell = collection.dataSource?.collectionView(collection, cellForItemAt: IndexPath(item: 0, section: 0))
            XCTAssertTrue(cell is CharactersViewCell)
        } else {
            XCTFail()
        }
    }
    
    func testRowSelection() {
        sut.displayLoadNextPage(viewModel: CharactersSeeds.loadNextPageViewModel)
        if let view = sut.view as? CharactersView,
           let delegate = view.collectionView.delegate {
            let indexPath = IndexPath(item: 0, section: 0)
            delegate.collectionView?(view.collectionView, didSelectItemAt: indexPath)
            XCTAssertTrue(interactorSpy.selectCharacterCalled)
            XCTAssertTrue(routerSpy.routeToDetailsCalledCalled)
        } else {
            XCTFail()
        }
    }
}
