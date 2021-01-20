//
//  CharacterDetailsWorkerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharacterDetailsWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharacterDetailsWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = CharacterDetailsWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
