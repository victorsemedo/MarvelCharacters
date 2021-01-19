//
//  CharactersTabViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

class CharactersTabViewController: UITabBarController {
    
    var selectedCharacterIndex: Int?
    
    init(selectedCharacterIndex: Int?) {
        self.selectedCharacterIndex = selectedCharacterIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension CharactersTabViewController {
    
    func setupView() {
        let charactersScene = UINavigationController(rootViewController: CharactersFactory.setupCharacters(selectedCharacterIndex: selectedCharacterIndex))
        charactersScene.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let favoritosScene = UINavigationController(rootViewController: FavoritesFactory.setupFavorites())
        favoritosScene.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        viewControllers = [charactersScene, favoritosScene]
        tabBar.tintColor = .primaryRed
    }
}
