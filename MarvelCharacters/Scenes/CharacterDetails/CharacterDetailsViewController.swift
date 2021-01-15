//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CharacterDetailsDisplayLogic: class {
    func displayData(viewModel: CharacterDetails.LoadData.ViewModel)
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
        interactor?.loadData(request: CharacterDetails.LoadData.Request())
    }
    
    // MARK: Architecture Setup
    func setup(interactor: CharacterDetailsBusinessLogic? = nil, router: CharacterDetailsRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Display Logic Protocol
extension CharacterDetailsViewController: CharacterDetailsDisplayLogic {
    func displayData(viewModel: CharacterDetails.LoadData.ViewModel) {
        customView.imageView.loadImage(fromUrl: viewModel.imageUrl ?? "")
        customView.descriptionLabel.text = viewModel.description
        title = viewModel.name
    }
}
