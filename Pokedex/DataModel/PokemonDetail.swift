//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 21/06/25.
//

import Foundation

struct PokemonDetail {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let imageUrl: String
    let types: [PokemonType]
    let stats: [PokemonStat]
}
