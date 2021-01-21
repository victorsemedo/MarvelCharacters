//
//  FavoritesInteractorTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class FavoritesInteractorTests: XCTestCase {
    // MARK: Subject under test
    var sut: FavoritesInteractor!
    var presenterSpy: FavoritesPresenterSpy!
    var workerSpy: FavoritesWorkerSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        presenterSpy = FavoritesPresenterSpy()
        workerSpy = FavoritesWorkerSpy()
        sut = FavoritesInteractor(presenter: presenterSpy, worker: workerSpy)
    }
    
    override func tearDown() {
        presenterSpy = nil
        workerSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testfecthAllSuccess(request: Favorites.FecthAll.Request) {
        workerSpy.loadFavoritesResult = .success
        sut.fecthAll(request: Favorites.FecthAll.Request(filterName: nil))
        XCTAssertNotNil(presenterSpy.presentFetchAllResponse)
        XCTAssertNil(presenterSpy.presentError)
        XCTAssertEqual(presenterSpy.presentFetchAllResponse?.characters.count, 20)
    }
    
    func testfecthAllSuccessEmpty(request: Favorites.FecthAll.Request) {
        workerSpy.loadFavoritesResult = .empty
        sut.fecthAll(request: Favorites.FecthAll.Request(filterName: nil))
        XCTAssertNotNil(presenterSpy.presentFetchAllResponse)
        XCTAssertNil(presenterSpy.presentError)
        XCTAssertEqual(presenterSpy.presentFetchAllResponse?.characters.count, 0)
    }
    
    func testfecthAllError(request: Favorites.FecthAll.Request) {
        workerSpy.loadFavoritesResult = .error
        sut.fecthAll(request: Favorites.FecthAll.Request(filterName: nil))
        XCTAssertNil(presenterSpy.presentFetchAllResponse)
        XCTAssertNotNil(presenterSpy.presentError)
        XCTAssertEqual(presenterSpy.presentError?.localizedDescription, DataProviderError.fetch.localizedDescription)
    }
    
    func testSelectCharacter(request: Favorites.FecthAll.Request) {
        workerSpy.loadFavoritesResult = .success
        sut.fecthAll(request: Favorites.FecthAll.Request(filterName: nil))
        sut.selectCharacter(request: Favorites.SelectCharacter.Request(index: 1))
        XCTAssertNotNil(sut.selectedCharacter)
        XCTAssertEqual(sut.selectedCharacter?.id, FavoritesSeeds.fecthAllResponse.characters[1].id)
    }
    
    func testSetFavorite() {
        workerSpy.loadFavoritesResult = .success
        sut.fecthAll(request: Favorites.FecthAll.Request(filterName: nil))
        workerSpy.saveAndDeleteResult = true
        sut.updateFavorite(request: Favorites.UpdateFavorite.Request.init(index: 1, isFavorite: true, image: nil))
        XCTAssertNotNil(workerSpy.saveFavoriteCharacter)
    }
    
    func testSetFavoriteFail() {
        workerSpy.loadFavoritesResult = .success
        sut.fecthAll(request: Favorites.FecthAll.Request(filterName: nil))
        workerSpy.saveAndDeleteResult = false
        sut.updateFavorite(request: Favorites.UpdateFavorite.Request(index: 1, isFavorite: true, image: nil))
        XCTAssertNotNil(workerSpy.saveFavoriteCharacter)
        XCTAssertEqual(presenterSpy.presentError?.localizedDescription, DataProviderError.save.localizedDescription)
    }
    
    func testRemoveFavorite() {
        workerSpy.loadFavoritesResult = .success
        sut.fecthAll(request: Favorites.FecthAll.Request(filterName: nil))
        workerSpy.saveAndDeleteResult = true
        sut.updateFavorite(request: Favorites.UpdateFavorite.Request(index: 1, isFavorite: false, image: nil))
        XCTAssertNotNil(workerSpy.deleteFavoriteCharacter)
    }
    
    func testRemoveFavoriteFail() {
        workerSpy.loadFavoritesResult = .success
        sut.fecthAll(request: Favorites.FecthAll.Request(filterName: nil))
        workerSpy.saveAndDeleteResult = false
        sut.updateFavorite(request: Favorites.UpdateFavorite.Request(index: 1, isFavorite: false, image: nil))
        XCTAssertNotNil(workerSpy.deleteFavoriteCharacter)
        XCTAssertEqual(presenterSpy.presentError?.localizedDescription, DataProviderError.delete.localizedDescription)
    }
}
