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
    func displayUpdateFavorite(viewModel: CharacterDetails.UpdateFavorite.ViewModel)
    func displayComicsAndSeriesError(isComics: Bool, message: String)
    func displayError(title: String, message: String)
}

final class CharacterDetailsViewController: UIViewController {
    private var interactor: CharacterDetailsBusinessLogic?
    private var router: CharacterDetailsRoutingLogic?
    
    private var customView = CharacterDetailsView()
    
    override func loadView() {
        view = customView
        customView.customDelegate = self
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
        if let image = viewModel.image {
            customView.imageView.image = image
        } else if let imageUrl = viewModel.imageUrl, imageUrl.count > 0 {
            customView.imageView.loadImage(fromUrl: imageUrl)
        }
        customView.favoriteView.isFilled = viewModel.isFavorite ?? false
        customView.descriptionLabel.text = viewModel.description
        title = viewModel.name
    }
    
    func displayComicsAndSeries(viewModel: CharacterDetails.LoadComicsSeries.ViewModel) {
        customView.comicsView.viewModel = CarouselView.ViewModel(cells: viewModel.comics)
        customView.seriesView.viewModel = CarouselView.ViewModel(cells: viewModel.series)
    }
    
    func displayUpdateFavorite(viewModel: CharacterDetails.UpdateFavorite.ViewModel) {
        if !viewModel.result {
            customView.favoriteView.toogleFill()
        }
    }
    
    func displayComicsAndSeriesError(isComics: Bool, message: String) {
        if isComics {
            customView.comicsView.heightConstraint?.constant = 50
            customView.comicsView.titleLabel.text = message
        } else {
            customView.seriesView.heightConstraint?.constant = 50
            customView.seriesView.titleLabel.text = message
        }
    }
    
    func displayError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: Strings.ok.localizable, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension CharacterDetailsViewController: CharacterDetailsViewDelegate {
    
    func setFavorite(_ view: CharacterDetailsView, value: Bool) {
        interactor?.updateFavorite(request: CharacterDetails.UpdateFavorite.Request(isFavorite: value, image: view.imageView.image))
    }
}
