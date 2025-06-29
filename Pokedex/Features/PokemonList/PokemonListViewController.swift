//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit

class PokemonListViewController: UIViewController {

    private let pokemonListView = PokemonListView()
    private let pokemonListViewModel = PokemonListViewModel()
    
    private lazy var searchController:UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = AppString.Text.searchPlaceholder
        return searchController
    }()
    
    override func loadView() {
        self.view = pokemonListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegatesAndDataSources()
        self.pokemonListViewModel.fetchPokemons()
        self.configNagivationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = AppColor.neutralDarkGray
    }
    
    private func setDelegatesAndDataSources() {
        self.pokemonListView.setTableViewDelegateAndDataSource(delegate: self, dataSource: self)
        self.pokemonListViewModel.delegate = self
    }
    
    private func configNagivationBar() {
        title = AppString.Title.titlePokedex
        
        // Search Controller
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - Delegate and DataSource TableView
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonListViewModel.numberOfPokemons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        cell.configCell(pokemon: self.pokemonListViewModel.getPokemon(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let pokemon = self.pokemonListViewModel.getPokemon(index: indexPath.row)
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

extension PokemonListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        self.pokemonListViewModel.filterPokemons(query: query)
    }
}
