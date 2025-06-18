//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit

class PokemonListViewController: UIViewController {

    private let pokemonListView = PokemonListView()
    private let pokeminListViewModel = PokemonListViewModel()
    
    override func loadView() {
        self.view = pokemonListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegatesAndDataSources()
        self.pokeminListViewModel.fetchPokemons()
        self.configNagivationBar()
    }
    
    private func setDelegatesAndDataSources() {
        self.pokemonListView.setTableViewDelegateAndDataSource(delegate: self, dataSource: self)
        self.pokeminListViewModel.delegate = self
    }
    
    private func configNagivationBar() {
        let backItem = UIBarButtonItem()
        backItem.title = "Pokédex"
        backItem.tintColor = .white
        navigationItem.backBarButtonItem = backItem
    }
}

// MARK: - Delegate and DataSource TableView
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokeminListViewModel.numberOfPokemons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        cell.configCell(pokemon: self.pokeminListViewModel.getPokemon(index: indexPath.row))
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let pokemon = self.pokeminListViewModel.getPokemon(index: indexPath.row)
        let pokemonDetailViewController = PokemonDetailViewController(url: pokemon.pokemonUrl)
        self.navigationController?.pushViewController(pokemonDetailViewController, animated: true)
    }
}

// MARK: - ViewModel Delegate
extension PokemonListViewController: PokemonListViewModelDelegate {
    func didUpdatePokemonList() {
        DispatchQueue.main.async {
            self.pokemonListView.reloadTableView()
        }
    }
    
    func didFailWithError(message: String) {
        DispatchQueue.main.async {
            self.showAlert(message: "Erro ao carregar lista de pokemons: \(message)")
        }
    }
}
