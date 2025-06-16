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
    }
    
    private func setDelegatesAndDataSources() {
        self.pokemonListView.setTableViewDelegateAndDataSource(delegate: self, dataSource: self)
        self.pokeminListViewModel.delegate = self
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
        print("célula \(indexPath.row) selecionada!")
//        tableView.deselectRow(at: indexPath, animated: true)
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
        print("Erro ao buscar pokemons: \(message)")
    }
}
