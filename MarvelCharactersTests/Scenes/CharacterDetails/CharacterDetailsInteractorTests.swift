//
//  CharacterDetailsInteractorTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharacterDetailsInteractorTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharacterDetailsInteractor!
    var presenterSpy: CharacterDetailsPresenterSpy!
    var workerSpy: CharacterDetailsWorkerSpy!
    
    let testCharacter = CharacterDetailsSeeds.loadCharacterResponse.character
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        presenterSpy = CharacterDetailsPresenterSpy()
        workerSpy = CharacterDetailsWorkerSpy()
        sut = CharacterDetailsInteractor(presenter: presenterSpy, worker: workerSpy)
        sut.character = testCharacter
    }
    
    override func tearDown() {
        presenterSpy = nil
        workerSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testLoadCharacter() {
        sut.loadCharacter(request: CharacterDetails.LoadCharacter.Request())
        XCTAssertNotNil(presenterSpy.presentCharacterResponse)
        XCTAssertNotNil(presenterSpy.presentCharacterResponse?.character)
        XCTAssertEqual(presenterSpy.presentCharacterResponse?.character?.id, testCharacter?.id)
    }
    
    func loadComicsSeriesSuccess(request: CharacterDetails.LoadComicsSeries.Request) {
        workerSpy.apiResultType = .success
        sut.loadComicsSeries(request: CharacterDetails.LoadComicsSeries.Request())
        XCTAssertNotNil(presenterSpy.presentComicsAndSeriesResponse)
        XCTAssertNotNil(presenterSpy.presentComicsAndSeriesResponse?.comics)
        XCTAssertEqual(presenterSpy.presentComicsAndSeriesResponse?.comics.count, 3)
        XCTAssertEqual(presenterSpy.presentComicsAndSeriesResponse?.series.count, 2)
    }
    
    func loadComicsSeriesEmpty(request: CharacterDetails.LoadComicsSeries.Request) {
        workerSpy.apiResultType = .empty
        sut.loadComicsSeries(request: CharacterDetails.LoadComicsSeries.Request())
        XCTAssertNotNil(presenterSpy.presentComicsAndSeriesResponse)
        XCTAssertNotNil(presenterSpy.presentComicsAndSeriesResponse?.comics)
        XCTAssertEqual(presenterSpy.presentComicsAndSeriesResponse?.comics.count, 0)
        XCTAssertEqual(presenterSpy.presentComicsAndSeriesResponse?.series.count, 0)
    }
    
    func loadComicsSeriesError(request: CharacterDetails.LoadComicsSeries.Request) {
        workerSpy.apiResultType = .unknown
        sut.loadComicsSeries(request: CharacterDetails.LoadComicsSeries.Request())
        XCTAssertNotNil(presenterSpy.presentComicsAndSeriesResponse)
        XCTAssertNotNil(presenterSpy.presentComicsAndSeriesResponse?.comics)
        XCTAssertEqual(presenterSpy.presentComicsAndSeriesResponse?.comics.count, 0)
        XCTAssertEqual(presenterSpy.presentComicsAndSeriesResponse?.series.count, 0)
    }
    
    func testSetFavorite() {
        workerSpy.saveAndDeleteResult = true
        sut.updateFavorite(request: CharacterDetails.UpdateFavorite.Request(isFavorite: true, image: nil))
        XCTAssertNotNil(workerSpy.saveFavoriteCharacter)
    }
    
    func testSetFavoriteFail() {
        workerSpy.saveAndDeleteResult = false
        sut.updateFavorite(request: CharacterDetails.UpdateFavorite.Request(isFavorite: true, image: nil))
        XCTAssertNotNil(workerSpy.saveFavoriteCharacter)
        XCTAssertEqual(presenterSpy.presentError?.localizedDescription, DataProviderError.save.localizedDescription)
    }
    
    func testRemoveFavorite() {
        workerSpy.saveAndDeleteResult = true
        sut.updateFavorite(request: CharacterDetails.UpdateFavorite.Request(isFavorite: false, image: nil))
        XCTAssertNotNil(workerSpy.deleteFavoriteCharacter)
    }

    
    func testRemoveFavoriteFail() {
        workerSpy.saveAndDeleteResult = false
        sut.updateFavorite(request: CharacterDetails.UpdateFavorite.Request(isFavorite: false, image: nil))
        XCTAssertNotNil(workerSpy.deleteFavoriteCharacter)
        XCTAssertEqual(presenterSpy.presentError?.localizedDescription, DataProviderError.delete.localizedDescription)
    }
}
