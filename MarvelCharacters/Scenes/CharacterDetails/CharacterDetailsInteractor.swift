//
//  CharacterDetailsInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CharacterDetailsBusinessLogic {
    func loadCharacter(request: CharacterDetails.LoadCharacter.Request)
    func loadComicsSeries(request: CharacterDetails.LoadComicsSeries.Request)
    func updateFavorite(request: CharacterDetails.UpdateFavorite.Request)
}

protocol CharacterDetailsDataStore {
    var character: Character? { get }
}

final class CharacterDetailsInteractor: CharacterDetailsDataStore {
    
    var character: Character?
    
    private var presenter: CharacterDetailsPresentationLogic?
    private var worker: CharacterDetailsWorkLogic
    
    init(presenter: CharacterDetailsPresentationLogic, worker: CharacterDetailsWorkLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: Business Logic Protocol
extension CharacterDetailsInteractor: CharacterDetailsBusinessLogic {
    
    func loadCharacter(request: CharacterDetails.LoadCharacter.Request) {
        presenter?.presentCharacter(response: CharacterDetails.LoadCharacter.Response(character: character))
    }
    
    func loadComicsSeries(request: CharacterDetails.LoadComicsSeries.Request) {
        guard let id = character?.id else { return }
        var comics = [Comic]()
        var series = [Serie]()
        
        worker.fetchComics(byId: id) { [weak self] (comicsResult) in
            guard let strongSelf = self else {return}
            switch comicsResult {
            case .success(let response):
                comics.append(contentsOf: response)
            case .failure(let error):
                strongSelf.presenter?.presentComicsAndSeriesError(isComics: true, error: error)
                break
            }
            self?.worker.fetchSeries(byId: id) { (seriesResult) in
                guard let strongSelf = self else {return}
                switch seriesResult {
                case .success(let response):
                    series.append(contentsOf: response)
                case .failure(let error):
                    strongSelf.presenter?.presentComicsAndSeriesError(isComics: false, error: error)
                }
                let response = CharacterDetails.LoadComicsSeries.Response.init(comics: comics, series: series)
                strongSelf.presenter?.presentComicsAndSeries(response: response)
            }
        }
    }
    
    func updateFavorite(request: CharacterDetails.UpdateFavorite.Request) {
        if let character = character {
            if request.isFavorite {
                worker.saveFovoriteCharacter(character, image: request.image) { [weak self] (result) in
                    guard let strongSelf = self else {return}
                    strongSelf.validateUpdateFavoriteResult(result)
                }
            } else {
                worker.deleteFavoriteCharacter(character) { [weak self] (result) in
                    guard let strongSelf = self else {return}
                    strongSelf.validateUpdateFavoriteResult(result)
                }
            }
        }
    }
}

private extension CharacterDetailsInteractor {

    func validateUpdateFavoriteResult(_ result: Result<Bool, DataProviderError>) {
        switch result {
        case .success(let value):
            let response = CharacterDetails.UpdateFavorite.Response(result: value)
            self.presenter?.presentUpdateFavorite(response: response)
        case .failure(let error):
            self.presenter?.presentError(error: error)
        }
    }
}

