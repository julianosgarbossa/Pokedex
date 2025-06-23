//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    private let pokemonDetailViewModel: PokemonDetailViewModel
    
    private let pokemonDetailView: PokemonDetailView = {
        let pokemonDetailView = PokemonDetailView()
        pokemonDetailView.translatesAutoresizingMaskIntoConstraints = false
        pokemonDetailView.backgroundColor = AppColor.neutralLightGray
        return pokemonDetailView
    }()
    
    init(url: URL?) {
        self.pokemonDetailViewModel = PokemonDetailViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setVisualElements()
        self.pokemonDetailViewModel.fetchPokemonDetail()
        self.setDelegatesAndDataSources()
    }
    
    private func setDelegatesAndDataSources() {
        self.pokemonDetailViewModel.delegate = self
        self.pokemonDetailView.delegate = self
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

// MARK: - PokemonDetailViewModelDelegate
extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func didLoadPokemonDetail(detail: PokemonDetail, isFavorited: Bool) {
        DispatchQueue.main.async {
            self.pokemonDetailView.configView(with: detail, isFavorited: isFavorited)
        }
    }
    
    func didFailToLoadDetail(with error: any Error) {
        DispatchQueue.main.async {
            self.showAlert(message: AppString.Alert.errorDetail + AppString.Text.space + error.localizedDescription)
        }
    }
}

// MARK: - PokemonDetailViewDelegate
extension PokemonDetailViewController: PokemonDetailViewDelegate {
    func didTapFavorite() {
        self.pokemonDetailViewModel.toggleFavorite()
    }
}

