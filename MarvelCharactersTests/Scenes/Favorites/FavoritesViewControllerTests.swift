//
//  FavoritesViewControllerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class FavoritesViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: FavoritesViewController!
    var interactorSpy: FavoritesInteractorSpy!
    var routerSpy: FavoritesRouterSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        interactorSpy = FavoritesInteractorSpy()
        routerSpy = FavoritesRouterSpy()
        sut = FavoritesViewController()
        sut.setup(interactor: interactorSpy, router: routerSpy)
        _ = sut.view
        sut.viewWillAppear(true)
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
            XCTAssertEqual(sut.title, Strings.favorites.localizable.uppercased())
        } else {
            XCTFail()
        }
    }
    
    func testloadNextPage() {
        XCTAssertNotNil(interactorSpy.fecthAllRequest)
    }
    
    func testCollectionView() {
        sut.displayFetchAll(viewModel: FavoritesSeeds.fecthAllViewModel)
        let view = sut.view as? CharactersView
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
        sut.displayFetchAll(viewModel: FavoritesSeeds.fecthAllViewModel)
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
    
    func testDidUpdateSearchBar() {
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            view.searchBar.text = "Iron "
            delegate.didUpdateSearchBar(view)
            XCTAssertNotNil(interactorSpy.fecthAllRequest)
            XCTAssertEqual(interactorSpy.fecthAllRequest?.filterName, "Iron ")
        } else {
            XCTFail()
        }
    }
    
    func testDidUpdateFavorite() {
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            let indexPath = IndexPath(row: 1, section: 0)
            delegate.didUpdateFavorite(view, forIndexPath: indexPath, withValue: true)
            XCTAssertNotNil(interactorSpy.updateFavoriteRequest)
            XCTAssertEqual(interactorSpy.updateFavoriteRequest?.index, indexPath.row)
            XCTAssertEqual(interactorSpy.updateFavoriteRequest?.isFavorite, true)
        } else {
            XCTFail()
        }
    }

    func testDidPullToRefresh() {
        interactorSpy.fecthAllRequest = nil
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            delegate.didPullToRefresh(view)
            XCTAssertTrue(view.refreshControl.isRefreshing)
            XCTAssertNotNil(interactorSpy.fecthAllRequest)
        } else {
            XCTFail()
        }
    }
    
    func testDisplayFetchAll() {
        sut.displayFetchAll(viewModel: FavoritesSeeds.fecthAllViewModel)
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            XCTAssertFalse(view.refreshControl.isRefreshing)
            XCTAssertEqual(view.viewModel?.cells.count, 20)
            XCTAssertNil(view.viewModel?.emptyType)
        } else {
            XCTFail()
        }
    }
    
    func testDisplayFetchAllEmpty() {
        sut.displayFetchAll(viewModel: FavoritesSeeds.fecthAllEmptyViewModel)
        if let view = sut.view as? CharactersView,
           let delegate = view.delegate {
            XCTAssertFalse(view.refreshControl.isRefreshing)
            XCTAssertEqual(view.viewModel?.cells.count, 0)
            XCTAssertEqual(view.viewModel?.emptyType, .emptyFavorites)
        } else {
            XCTFail()
        }
    }

}
