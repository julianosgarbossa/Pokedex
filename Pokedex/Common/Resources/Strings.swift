//
//  Strings.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 19/06/25.
//

enum AppString {

    enum Title {
        static let titlePokedex = "Pokédex"
        static let titleFavorite = "Favoritos"
    }
    
    enum Button {
        static let favorite = "Favoritar"
        static let unfavorite = "Remover"
    }
    
    enum Image {
        static let pokemonImageDefault = "pokemonImageDefault"
        static let favoriteSelected = "heart.fill"
        static let favoriteUnselected = "heart"
    }
    
    enum Text {
        static let space = " "
        static let numberFormat = "#%03d"
        static let statusBaseTitle = "Status Base"
        static let statAttack = "Attack"
        static let statSpAttack = "Sp. Atk"
        static let statSpeed = "Speed"
        static let statHp = "HP"
        static let statDefense = "Defense"
        static let statSpDefense = "Sp. Def"
        static let searchPlaceholder = "Buscar Pokémon"
    }
    
    enum Alert {
        static let errorDetail = "Erro ao carregar detalhes do Pokemon:"
    }
    
    enum Key {
        static let favoritesKey = "FavoritePokemon"
    }
}
