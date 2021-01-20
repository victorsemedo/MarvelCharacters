//
//  FavoritesWorkerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class FavoritesWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: FavoritesWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = FavoritesWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
