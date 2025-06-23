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
    private(set) var filteredPokemons: [Pokemon] = []
    
    var isFiltering: Bool = false
    
    var numberOfPokemons: Int {
        return isFiltering ? filteredPokemons.count : pokemons.count
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
        return isFiltering ? filteredPokemons[index] : pokemons[index]
    }
    
    func filterPokemons(query: String) {
        if query.isEmpty {
            isFiltering = false
            filteredPokemons = []
        } else {
            isFiltering = true
            filteredPokemons = pokemons.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
        delegate?.didUpdatePokemonList()
    }
}
