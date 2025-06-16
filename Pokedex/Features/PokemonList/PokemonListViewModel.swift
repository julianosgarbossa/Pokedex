//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func didUpdatePokemonList()
    func didFailWithError(message: String)
}

class PokemonListViewModel {
    
    weak var delegate: PokemonListViewModelDelegate?
    private let service: PokemonServiceProtocol
    private(set) var pokemons: [Pokemon] = []
    var numberOfPokemons: Int {
        return pokemons.count
    }
    
    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
    }
    
    func fetchPokemons() {
        service.fetchPokemonList { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemons = pokemons
                self?.delegate?.didUpdatePokemonList()
            case .failure(let error):
                self?.delegate?.didFailWithError(message: error.localizedDescription)
            }
        }
    }
    
    func getPokemon(index: Int) -> Pokemon {
        return pokemons[index]
    }
}
