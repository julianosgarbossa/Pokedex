//
//  PokemonDetailResponse.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 21/06/25.
//

import Foundation

struct PokemonDetailResponse: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let stats: [StatElementResponse]
    let types: [TypeElementResponse]
}

struct StatElementResponse: Decodable {
    let baseStat: Int
    let stat: StatInfoResponse
    
    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatInfoResponse: Decodable {
    let name: String
}

struct TypeElementResponse: Decodable {
    let type: TypeInfoResponse
}

struct TypeInfoResponse: Decodable {
    let name: String
}

extension PokemonDetailResponse {
    func toDomainModel() -> PokemonDetail {
        let pokemonTypes = types.compactMap { PokemonType(rawValue: $0.type.name) }
        let pokemonImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        let pokemonStats = stats.map { PokemonStat(name: $0.stat.name, value: $0.baseStat) }
        return PokemonDetail(id: id,
                             name: name,
                             height: Double(height) / 10,
                             weight: Double(weight) / 10,
                             imageUrl: pokemonImageUrl,
                             types: pokemonTypes,
                             stats: pokemonStats)
    }
}
