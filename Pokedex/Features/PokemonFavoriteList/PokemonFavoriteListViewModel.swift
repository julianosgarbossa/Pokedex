//
//  PokemonFavoriteListViewModel.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 23/06/25.
//

import Foundation
protocol PokemonFavoriteListViewModelDelegate: AnyObject {
    func didUpdatePokemonFavoriteList()
    func didFailWithError(message: String)
}

final class PokemonFavoriteListViewModel {
    
    weak var delegate: PokemonFavoriteListViewModelDelegate?
    
    private let service: PokemonServiceProtocol
    private(set) var favoritePokemons: [Pokemon] = []
    
    var numberOfPokemonsFavorite: Int {
        return favoritePokemons.count
    }
    
    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
    }
    
    func fetchFavorites() {
        let favoriteNames = FavoritePokemonUserDefaultsRepository.shared.allFavorites()
        
        service.fetchPokemonList { [weak self] result in
            switch result {
            case .success(let pokemons):
                let filtered = pokemons.filter { favoriteNames.contains($0.name.lowercased()) }
                self?.favoritePokemons = filtered
                self?.delegate?.didUpdatePokemonFavoriteList()
            case .failure(let error):
                self?.delegate?.didFailWithError(message: error.localizedDescription)
            }
        }
    }
    
    func getPokemonFavorite (index: Int) -> Pokemon {
        return favoritePokemons[index]
    }
}
