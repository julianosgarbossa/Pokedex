//
//  PokemonFavoriteCollectionViewCell.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 23/06/25.
//

import UIKit

class PokemonFavoriteCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: PokemonFavoriteCollectionViewCell.self)
    
    private let pokemonFavoriteCell: PokemonFavoriteCell = {
        let pokemonFavoriteCell = PokemonFavoriteCell()
        pokemonFavoriteCell.translatesAutoresizingMaskIntoConstraints = false
        return pokemonFavoriteCell
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        contentView.addSubview(pokemonFavoriteCell)
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonFavoriteCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonFavoriteCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonFavoriteCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonFavoriteCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configCell(pokemon: Pokemon) {
        self.pokemonFavoriteCell.configViewCell(pokemon: pokemon)
    }
}
