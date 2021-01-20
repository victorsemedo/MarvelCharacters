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

}
