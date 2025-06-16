//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import Foundation

struct PokemonListResponse: Decodable {
    let results: [PokemonResponse]
}

struct PokemonResponse: Decodable {
    let name: String
    let pokemonUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case pokemonUrl = "url"
    }
}
