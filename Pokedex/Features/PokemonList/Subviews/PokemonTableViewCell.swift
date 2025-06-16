//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: PokemonTableViewCell.self)

    private let pokemonViewCell: PokemonViewCell = {
        let pokemonViewCell = PokemonViewCell()
        pokemonViewCell.translatesAutoresizingMaskIntoConstraints = false
        return pokemonViewCell
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        contentView.addSubview(pokemonViewCell)
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    override func prepareForReuse() {
//        self.pokemonViewCell.prepareForReuse()
    }
}
