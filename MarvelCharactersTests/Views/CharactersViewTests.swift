//
//  CharactersViewTests.swift
//  MarvelCharactersTests
//
//  Created by Victor Tavares on 21/01/21.
//

import FBSnapshotTestCase
@testable import MarvelCharacters

class CharactersViewTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        recordMode = false
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testCharacterGrid() {
        let fourCharacters = CharactersSeeds.loadNextPage.characters[0..<4]
        var characters = Array(fourCharacters)
        let image = UIImage(named: "black_panther",
                            in: Bundle(for: CharactersView.self),
                            compatibleWith: nil)
        for index in 0..<characters.count {
            characters[index].image = image
        }
        snapshot(cells: characters, emptyType: nil)
    }
    
    func testCharacterGridInternetConnection() {
        snapshot(cells: [Character](), emptyType: .internetConnection)
    }

    func testCharacterGridApiError() {
        snapshot(cells: [Character](), emptyType: .apiError)
    }
    
    func testCharacterGridEmptyFavorites() {
        snapshot(cells: [Character](), emptyType: .emptyFavorites)
    }
    
    @discardableResult
    private func snapshot(cells: [CharactersCellProtocol], emptyType: CharactersEmptyType?) -> CharactersView  {
        let sut = CharactersView()
        sut.viewModel = CharactersView.ViewModel(cells: cells, emptyType: emptyType)
        addSubviewForTest(sut, constraints: { (vc: UIViewController) in
            [
                sut.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 24),
                sut.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
                sut.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
                sut.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            ]
        })
        verify(sut)
        return sut
    }
}
