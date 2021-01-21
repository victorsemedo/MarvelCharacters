//
//  CharactersInteractorTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharactersInteractorTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersInteractor!
    var presenterSpy: CharactersPresenterSpy!
    var workerSpy: CharactersWorkerSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        presenterSpy = CharactersPresenterSpy()
        workerSpy = CharactersWorkerSpy()
        sut = CharactersInteractor(presenter: presenterSpy, worker: workerSpy)
    }
    
    override func tearDown() {
        presenterSpy = nil
        workerSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testLoadNextPageSuccess() {
        workerSpy.apiResultType = .success
        sut.loadNextPage(request: Characters.LoadNextPage.Request(page: 0, searchName: nil, reset: true))
        XCTAssertNotNil(presenterSpy.presentLoadNextPageResponse)
        XCTAssertNil(presenterSpy.presentError)
        XCTAssertEqual(presenterSpy.presentLoadNextPageResponse?.characters.count, 20)
    }
    
    func testLoadNextPageEmpty() {
        workerSpy.apiResultType = .empty
        sut.loadNextPage(request: Characters.LoadNextPage.Request(page: 0, searchName: "Hydra", reset: true))
        XCTAssertNotNil(presenterSpy.presentLoadNextPageResponse)
        XCTAssertNil(presenterSpy.presentError)
        XCTAssertEqual(presenterSpy.presentLoadNextPageResponse?.characters.count, 0)
    }
    
    func testLoadNextPageError() {
        workerSpy.apiResultType = .noConnection
        sut.loadNextPage(request: Characters.LoadNextPage.Request(page: 0, searchName: nil, reset: true))
        XCTAssertNil(presenterSpy.presentLoadNextPageResponse)
        XCTAssertNotNil(presenterSpy.presentError)
        XCTAssertEqual(presenterSpy.presentError?.localizedDescription, APIError.noConnection.localizedDescription)
    }
    
    func testSelectCharacter() {
        workerSpy.apiResultType = .success
        sut.loadNextPage(request: Characters.LoadNextPage.Request(page: 0, searchName: nil, reset: true))
        sut.selectCharacter(request: Characters.SelectCharacter.Request(index: 0))
        XCTAssertNotNil(sut.selectedCharacter)
        XCTAssertEqual(sut.selectedCharacter?.id, CharactersSeeds.loadNextPage.characters[0].id)
    }
    
    func testSetFavorite() {
        workerSpy.apiResultType = .success
        sut.loadNextPage(request: Characters.LoadNextPage.Request(page: 0, searchName: nil, reset: true))
        workerSpy.saveAndDeleteResult = true
        sut.updateFavorite(request: Characters.UpdateFavorite.Request.init(index: 1, isFavorite: true, image: nil))
        XCTAssertNotNil(workerSpy.saveFavoriteCharacter)
    }
    
    func testRemoveFavorite() {
        workerSpy.apiResultType = .success
        sut.loadNextPage(request: Characters.LoadNextPage.Request(page: 0, searchName: nil, reset: true))
        workerSpy.saveAndDeleteResult = true
        sut.updateFavorite(request: Characters.UpdateFavorite.Request(index: 1, isFavorite: false, image: nil))
        XCTAssertNotNil(workerSpy.deleteFavoriteCharacter)
    }
    
    func testSetFavoriteFail() {
        workerSpy.apiResultType = .success
        sut.loadNextPage(request: Characters.LoadNextPage.Request(page: 0, searchName: nil, reset: true))
        workerSpy.saveAndDeleteResult = false
        sut.updateFavorite(request: Characters.UpdateFavorite.Request(index: 1, isFavorite: true, image: nil))
        XCTAssertNotNil(workerSpy.saveFavoriteCharacter)
        XCTAssertEqual(presenterSpy.presentError?.localizedDescription, DataProviderError.save.localizedDescription)
    }
    
    func testRemoveFavoriteFail() {
        workerSpy.apiResultType = .success
        sut.loadNextPage(request: Characters.LoadNextPage.Request(page: 0, searchName: nil, reset: true))
        workerSpy.saveAndDeleteResult = false
        sut.updateFavorite(request: Characters.UpdateFavorite.Request(index: 1, isFavorite: true, image: nil))
        XCTAssertNil(workerSpy.deleteFavoriteCharacter)
        XCTAssertEqual(presenterSpy.presentError?.localizedDescription, DataProviderError.delete.localizedDescription)
    }
    
}
