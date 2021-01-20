//
//  CharactersWorkerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharactersWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = CharactersWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
