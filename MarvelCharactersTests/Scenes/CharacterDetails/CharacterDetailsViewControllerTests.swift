//
//  CharacterDetailsViewControllerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
import Kingfisher
@testable import MarvelCharacters

class CharacterDetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharacterDetailsViewController!
    var interactorSpy: CharacterDetailsInteractorSpy!
    var routerSpy: CharacterDetailsRouterSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        interactorSpy = CharacterDetailsInteractorSpy()
        routerSpy = CharacterDetailsRouterSpy()
        sut = CharacterDetailsViewController()
        sut.setup(interactor: interactorSpy, router: routerSpy)
        _ = sut.view
    }
    
    override func tearDown() {
        interactorSpy = nil
        routerSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testloadView() {
        if let view = sut.view as? CharacterDetailsView {
            XCTAssertNotNil(view.customDelegate)
            XCTAssertNotNil(view.comicsView.collectionView.delegate)
            XCTAssertNotNil(view.seriesView.collectionView.delegate)
            XCTAssertNotNil(view.comicsView.collectionView.dataSource)
            XCTAssertNotNil(view.seriesView.collectionView.dataSource)
        } else {
            XCTFail()
        }
    }
    
    func testloadNextPage() {
        XCTAssertNotNil(interactorSpy.loadCharacterRequest)
        XCTAssertNotNil(interactorSpy.loadComicsSeriesRequest)
    }

    func testDisplayCharacter(viewModel: CharacterDetails.LoadCharacter.ViewModel) {
        sut.displayCharacter(viewModel: CharacterDetailsSeeds.loadCharacterViewModel)
        if let view = sut.view as? CharacterDetailsView {
            XCTAssertTrue(view.favoriteView.isFilled)
            XCTAssertEqual(sut.title, viewModel.name)
            XCTAssertEqual(view.descriptionLabel.text, viewModel.description)
        } else {
            XCTFail()
        }
    }
    
    func testDisplayComicsAndSeries(viewModel: CharacterDetails.LoadComicsSeries.ViewModel) {
        sut.displayComicsAndSeries(viewModel: CharacterDetailsSeeds.loadComicsSeriesViewModel)
        if let view = sut.view as? CharacterDetailsView {
            XCTAssertEqual(view.comicsView.viewModel?.cells.count, 3)
            XCTAssertEqual(view.seriesView.viewModel?.cells.count, 2)
        } else {
            XCTFail()
        }
    }
    
    func testDisplayUpdateFavorite(viewModel: CharacterDetails.UpdateFavorite.ViewModel) {
        sut.displayUpdateFavorite(viewModel: CharacterDetailsSeeds.updateFavoriteViewModel)
        if let view = sut.view as? CharacterDetailsView {
            XCTAssertTrue(view.favoriteView.isHidden)
        } else {
            XCTFail()
        }
    }

}
