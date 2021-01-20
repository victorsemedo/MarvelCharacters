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

}
