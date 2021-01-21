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
            XCTAssertTrue(view.refreshControl.isRefreshing)
            XCTAssertNotNil(view.delegate)
            XCTAssertNotNil(view.collectionView.delegate)
            XCTAssertNotNil(view.collectionView.dataSource)
            XCTAssertEqual(sut.title, Strings.characters.localizable.uppercased())
        } else {
            XCTFail()
        }
    }
    
    func testloadNextPage() {
        XCTAssertNotNil(interactorSpy.loadNextPageRequest)
        XCTAssertNil(interactorSpy.reloadFavoritesRequest)
    }
    
    func testCollectionView() {
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
            XCTAssertNotNil(interactorSpy.selectCharacterRequest)
            XCTAssertNotNil(routerSpy.routeToDetailsCalled)
            XCTAssertEqual(interactorSpy.selectCharacterRequest?.index, indexPath.row)
        } else {
            XCTFail()
        }
    }
    
    func testWillDisplayLastCell() {
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            view.searchBar.text = "Iron "
            sut.displayLoadNextPage(viewModel: CharactersSeeds.loadNextPageViewModel)
            delegate.willDisplayLastCell(view)
            XCTAssertNotNil(interactorSpy.loadNextPageRequest)
            XCTAssertEqual(interactorSpy.loadNextPageRequest?.searchName, "Iron ")
            XCTAssertEqual(interactorSpy.loadNextPageRequest?.page, 1)
            XCTAssertEqual(interactorSpy.loadNextPageRequest?.reset, false)
        } else {
            XCTFail()
        }
    }
    
    func testDidUpdateSearchBar() {
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            view.searchBar.text = "Iron "
            sut.displayLoadNextPage(viewModel: CharactersSeeds.loadNextPageViewModel)
            delegate.didUpdateSearchBar(view)
            XCTAssertNotNil(interactorSpy.loadNextPageRequest)
            XCTAssertEqual(interactorSpy.loadNextPageRequest?.searchName, "Iron ")
            XCTAssertEqual(interactorSpy.loadNextPageRequest?.page, 0)
            XCTAssertEqual(interactorSpy.loadNextPageRequest?.reset, true)
        } else {
            XCTFail()
        }
    }
    
    func testDidUpdateFavorite() {
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            let indexPath = IndexPath(row: 1, section: 0)
            delegate.didUpdateFavorite(view, forIndexPath: indexPath, withValue: false)
            XCTAssertNotNil(interactorSpy.updateFavoriteRequest)
            XCTAssertEqual(interactorSpy.updateFavoriteRequest?.index, indexPath.row)
            XCTAssertEqual(interactorSpy.updateFavoriteRequest?.isFavorite, false)
        } else {
            XCTFail()
        }
    }

    func testDidPullToRefresh() {
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            delegate.didPullToRefresh(view)
            XCTAssertTrue(view.refreshControl.isRefreshing)
            XCTAssertNotNil(interactorSpy.loadNextPageRequest)
            XCTAssertNil(interactorSpy.loadNextPageRequest?.searchName)
            XCTAssertEqual(interactorSpy.loadNextPageRequest?.page, 0)
            XCTAssertEqual(interactorSpy.loadNextPageRequest?.reset, true)
        } else {
            XCTFail()
        }
    }
    
    func testDisplayError() {
        sut.displayError(emptyType: .apiError)
        if let view = sut.view as? CharactersView {
            XCTAssertFalse(view.refreshControl.isRefreshing)
            XCTAssertEqual(view.viewModel?.emptyType, .apiError)
            XCTAssertEqual(view.viewModel?.cells.count, 0)
        } else {
            XCTFail()
        }
    }

    func testDisplayLoadNextPage() {
        sut.displayLoadNextPage(viewModel: CharactersSeeds.loadNextPageViewModel)
        if let view = sut.view as? CharactersView {
            XCTAssertFalse(view.refreshControl.isRefreshing)
            let emptyView = view.collectionView.backgroundView as? CharactersEmptyView
            XCTAssertNil(emptyView)
            XCTAssertNil(view.viewModel?.emptyType)
            XCTAssertEqual(view.viewModel?.cells.count, 20)
        } else {
            XCTFail()
        }
    }
    
    func testDisplaySelectedCharacter() {
        interactorSpy.selectedCharacterIndex = 1
        sut.displayLoadNextPage(viewModel: CharactersSeeds.loadNextPageViewModel)
        XCTAssertNotNil(interactorSpy.selectCharacterRequest)
        XCTAssertEqual(interactorSpy.selectCharacterRequest?.index, 1)
        XCTAssertTrue(routerSpy.routeToDetailsCalled)
    }
}
