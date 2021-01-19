//
//  SceneDelegate.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 08/01/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        openedFromWidget(urlContexts: connectionOptions.urlContexts, window: windowScene)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let windowScene = scene as? UIWindowScene else { return }
        openedFromWidget(urlContexts: URLContexts, window: windowScene)
    }

    private func openedFromWidget(urlContexts: Set<UIOpenURLContext>, window: UIWindowScene) {
        guard let urlContext = urlContexts.first(where: { $0.url.scheme == "widget" }) else {
            routeToMain(windowScene: window)
            return
        }
        
        if urlContext.url.host?.contains("0") ?? false {
            routeToMain(windowScene: window, selectedCharacterIndex: 0)
        } else if urlContext.url.host?.contains("1") ?? false  {
            routeToMain(windowScene: window, selectedCharacterIndex: 1)
        } else if urlContext.url.host?.contains("2") ?? false  {
            routeToMain(windowScene: window, selectedCharacterIndex: 2)
        } else {
            //routeToMain(windowScene: window)
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        DataProvider.shareInstance.saveContext()
    }
    
    func routeToMain(windowScene: UIWindowScene, selectedCharacterIndex: Int? = nil) {
        let vc = CharactersTabViewController(selectedCharacterIndex: selectedCharacterIndex)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
}

