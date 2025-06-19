//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // Temp
    private let pokemonType: [String] = ["fire", "water"] // "grass", "poison", "flying", "electric", "ice", "ground", "fighting", "psychic", "rock", "bug", "ghost", "dragon", "dark", "steel"
    
    private let pokemonDetailView: PokemonDetailView = {
        let pokemonDetailView = PokemonDetailView()
        pokemonDetailView.translatesAutoresizingMaskIntoConstraints = false
        pokemonDetailView.backgroundColor = .white
        return pokemonDetailView
    }()
    
    // Temp
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setVisualElements()
        self.pokemonDetailView.configureTypes(pokemonType)
    }
    
    private func setVisualElements() {
        view.addSubview(pokemonDetailView)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

