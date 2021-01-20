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
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        presenterSpy = CharacterDetailsPresenterSpy()
        workerSpy = CharacterDetailsWorkerSpy()
        sut = CharacterDetailsInteractor(presenter: presenterSpy, worker: workerSpy)
    }
    
    override func tearDown() {
        presenterSpy = nil
        workerSpy = nil
        sut = nil
        super.tearDown()
    }
}
