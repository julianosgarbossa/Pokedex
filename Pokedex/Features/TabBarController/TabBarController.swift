//
//  TabBarController.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 23/06/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupTabBarController() {
        let pokemonListViewController = UINavigationController(rootViewController: PokemonListViewController())
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        let pokemonListViewControllerSymbol = UIImage(systemName: "list.bullet", withConfiguration: symbolConfiguration)
        pokemonListViewController.tabBarItem.image = pokemonListViewControllerSymbol
        pokemonListViewController.tabBarItem.title = "Pokemóns"
        
        let pokemonFavoriteListViewController = UINavigationController(rootViewController: PokemonFavoriteListViewController())
        let pokemonFavoriteListViewControllerSymbol = UIImage(systemName: "heart", withConfiguration: symbolConfiguration)
        pokemonFavoriteListViewController.tabBarItem.image = pokemonFavoriteListViewControllerSymbol
        pokemonFavoriteListViewController.tabBarItem.title = "Favoritos"
        
        tabBar.tintColor = AppColor.neutralDarkGray
        
        self.setViewControllers([pokemonListViewController, pokemonFavoriteListViewController], animated: true)
    }
}
