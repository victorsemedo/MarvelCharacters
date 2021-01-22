//
//  CarouselViewTests.swift
//  MarvelCharactersTests
//
//  Created by Victor Tavares on 21/01/21.
//

import FBSnapshotTestCase
@testable import MarvelCharacters

class CarouselViewTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait;
        recordMode = false
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testCarouselView() {
        var comics = CharacterDetailsSeeds.loadComicsSeriesResponse.comics
        comics = Array(comics[0..<2])
        let image = UIImage(named: "black_panther",
                            in: Bundle(for: CharactersView.self),
                            compatibleWith: nil)
        for index in 0..<comics.count {
            comics[index].image = image
        }
        snapshot(cells: comics)
    }

    @discardableResult
    private func snapshot(cells: [CarouselCellProtocol]) -> CarouselView  {
        let sut = CarouselView()
        sut.viewModel = CarouselView.ViewModel(cells: cells)
        addSubviewForTest(sut, constraints: { (vc: UIViewController) in
            [
                sut.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 24),
                sut.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
                sut.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
                sut.heightAnchor.constraint(equalToConstant: 250)
            ]
        })
        verify(sut)
        return sut
    }
    
}
