//
//  CharacterDetailsPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CharacterDetailsPresentationLogic {
    func presentCharacter(response: CharacterDetails.LoadCharacter.Response)
    func presentComicsAndSeries(response: CharacterDetails.LoadComicsSeries.Response)
    func presentUpdateFavorite(response: CharacterDetails.UpdateFavorite.Response)
    func presentError(error: Error)
    func presentComicsAndSeriesError(isComics: Bool, error: Error)
}

final class CharacterDetailsPresenter {
    private weak var viewController: CharacterDetailsDisplayLogic?
    
    init(viewController: CharacterDetailsDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: Presentation Logic Protocol
extension CharacterDetailsPresenter: CharacterDetailsPresentationLogic {
    func presentCharacter(response: CharacterDetails.LoadCharacter.Response) {
        let viewModel = CharacterDetails.LoadCharacter.ViewModel(name: response.character?.name,
                                                                 description: response.character?.description,
                                                                 imageUrl: response.character?.imageUrl,
                                                                 image: response.character?.image,
                                                                 isFavorite: response.character?.isFavorite)
        viewController?.displayCharacter(viewModel: viewModel)
    }
    
    func presentComicsAndSeries(response: CharacterDetails.LoadComicsSeries.Response) {
        self.viewController?.displayComicsAndSeries(viewModel: CharacterDetails.LoadComicsSeries.ViewModel(comics: response.comics, series: response.series))
        
        if response.comics.count == 0 {
            self.viewController?.displayComicsAndSeriesError(isComics: true, message: Strings.noComics.localizable.uppercased())
        }
        
        if response.series.count == 0 {
            self.viewController?.displayComicsAndSeriesError(isComics: false, message: Strings.noSeries.localizable.uppercased())
        }
    }
    
    func presentUpdateFavorite(response: CharacterDetails.UpdateFavorite.Response) {
        let viewModel = CharacterDetails.UpdateFavorite.ViewModel(result: response.result)
        viewController?.displayUpdateFavorite(viewModel: viewModel)
    }
    
    func presentError(error: Error) {
        if let error = error as? LocalizedError {
            viewController?.displayError(title: "", message: error.localizedDescription)
        }
    }
    
    func presentComicsAndSeriesError(isComics: Bool, error: Error) {
        var message = isComics ? Strings.noComics.localizable.uppercased() : Strings.noSeries.localizable.uppercased()
        if let error = error as? LocalizedError {
            message =  message + " | " + error.localizedDescription.uppercased()
        }
        viewController?.displayComicsAndSeriesError(isComics: isComics, message:message)
    }
    
}
