//
//  CharacterDetailsPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CharacterDetailsPresentationLogic {
    func presentData(response: CharacterDetails.LoadData.Response)
}

class CharacterDetailsPresenter {
    private weak var viewController: CharacterDetailsDisplayLogic?
    
    init(viewController: CharacterDetailsDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: Presentation Logic Protocol
extension CharacterDetailsPresenter: CharacterDetailsPresentationLogic {
    func presentData(response: CharacterDetails.LoadData.Response) {
        let imgUrl = "\(response.character?.thumbnail?.path ?? "").\(response.character?.thumbnail?.fileExtension ?? "")"
        let viewModel = CharacterDetails.LoadData.ViewModel(name: response.character?.name,
                                                            description: response.character?.description,
                                                            imageUrl: imgUrl,
                                                            image: nil)
        viewController?.displayData(viewModel: viewModel)
    }
}
