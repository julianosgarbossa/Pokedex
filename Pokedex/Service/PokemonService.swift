//
//  PokemonService.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

final class PokemonService: PokemonServiceProtocol {
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], any Error>) -> Void) {
        // Limite máximo 1302, pokemons mais conhecidos limite 151
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=1025"
        
        networkClient.fetch(from: urlString, decodeTo: PokemonListResponse.self) { result in
            switch result {
            case .success(let response):
                let pokemons = response.results.map { $0.toDomainModel() }
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
