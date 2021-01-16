//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CharacterDetailsDisplayLogic: class {
    
    func displayCharacter(viewModel: CharacterDetails.LoadCharacter.ViewModel)
    
    func displayComicsAndSeries(viewModel: CharacterDetails.LoadComicsSeries.ViewModel)
    
}

class CharacterDetailsViewController: UIViewController {
    private var interactor: CharacterDetailsBusinessLogic?
    private var router: CharacterDetailsRoutingLogic?
    
    private var customView = CharacterDetailsView()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadCharacter(request: CharacterDetails.LoadCharacter.Request())
        interactor?.loadComicsSeries(request: CharacterDetails.LoadComicsSeries.Request())
    }
    
    // MARK: Architecture Setup
    func setup(interactor: CharacterDetailsBusinessLogic? = nil, router: CharacterDetailsRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Display Logic Protocol
extension CharacterDetailsViewController: CharacterDetailsDisplayLogic {
    func displayCharacter(viewModel: CharacterDetails.LoadCharacter.ViewModel) {
        customView.imageView.loadImage(fromUrl: viewModel.imageUrl ?? "")
        customView.descriptionLabel.text = viewModel.description
        title = viewModel.name
    }
    
    func displayComicsAndSeries(viewModel: CharacterDetails.LoadComicsSeries.ViewModel) {
        customView.comicsView.viewModel = CarouselView.ViewModel(cells: viewModel.comics)
        customView.seriesView.viewModel = CarouselView.ViewModel(cells: viewModel.series)
    }
}
