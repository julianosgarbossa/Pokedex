//
//  PokemonFavoriteListViewController.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 23/06/25.
//

import UIKit

class PokemonFavoriteListViewController: UIViewController {

    private let pokemonFavoriteListView = PokemonFavoriteListView()
    private let pokemonFavoriteListViewModel = PokemonFavoriteListViewModel()
    
    override func loadView() {
        self.view = pokemonFavoriteListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setDelegatesAndDataSources()
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.pokemonFavoriteListViewModel.fetchFavorites()
        }
    }
    
    private func setDelegatesAndDataSources() {
        self.pokemonFavoriteListView.setTableViewDelegateAndDataSource(delegate: self, dataSource: self)
        self.pokemonFavoriteListViewModel.delegate = self
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: AppColor.neutralDarkGray
        ]
        title = AppString.Title.titleFavorite
    }
}


// MARK: - CollectionView Delegate, DataSource, FlowLayout
extension PokemonFavoriteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonFavoriteListViewModel.numberOfPokemonsFavorite
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonFavoriteCollectionViewCell.identifier, for: indexPath) as? PokemonFavoriteCollectionViewCell else { return UICollectionViewCell() }
        cell.configCell(pokemon: self.pokemonFavoriteListViewModel.getPokemonFavorite(index: indexPath.row))
        return cell
    }
}

extension PokemonFavoriteListViewController: UICollectionViewDelegateFlowLayout {
    
}

extension PokemonFavoriteListViewController: UICollectionViewDelegate {
    
}

// MARK: - ViewModel Delegate
extension PokemonFavoriteListViewController: PokemonFavoriteListViewModelDelegate {
    func didUpdatePokemonFavoriteList() {
        DispatchQueue.main.async {
            self.pokemonFavoriteListView.reloadCollectionView()
        }
    }
    
    func didFailWithError(message: String) {
        self.showAlert(message: "Erro ao carregar lista de pokemons favoritos: \(message)")
    }
}
