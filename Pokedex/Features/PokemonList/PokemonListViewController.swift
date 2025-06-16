//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit

class PokemonListViewController: UIViewController {

    private let pokemonListView = PokemonListView()
    
    // Temp
    let pokemonService = PokemonService()
    
    override func loadView() {
        self.view = pokemonListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegatesAndDataSources()
        self.TestAPI()

    }
    
    private func setDelegatesAndDataSources() {
        self.pokemonListView.setTableViewDelegateAndDataSource(delegate: self, dataSource: self)
    }
    
    // Temp
    private func TestAPI() {
        self.pokemonService.fetchPokemonList { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Delegate and DataSource TableView
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("célula \(indexPath.row) selecionada!")
//        tableView.deselectRow(at: indexPath, animated: true)
    }
}
