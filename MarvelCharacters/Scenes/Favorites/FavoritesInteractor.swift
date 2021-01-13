//
//  FavoritesInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesBusinessLogic {
    func doSomething(request: Favorites.Something.Request)
}

protocol FavoritesDataStore {
}

class FavoritesInteractor: FavoritesDataStore {
    private var presenter: FavoritesPresentationLogic?
    private var worker: FavoritesWorkLogic
    
    init(presenter: FavoritesPresentationLogic, worker: FavoritesWorkLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: Business Logic Protocol
extension FavoritesInteractor: FavoritesBusinessLogic {
    func doSomething(request: Favorites.Something.Request) {
    }
}
