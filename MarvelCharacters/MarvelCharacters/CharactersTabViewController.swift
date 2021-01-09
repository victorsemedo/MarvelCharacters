//
//  CharactersTabViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

class CharactersTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension CharactersTabViewController {
    
    func setupView() {
        let charactersScene = CharactersFactory.setupCharacters()
        charactersScene.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let favoritosScene = CharactersFactory.setupCharacters()
        favoritosScene.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        viewControllers = [charactersScene, favoritosScene]
    }
}
