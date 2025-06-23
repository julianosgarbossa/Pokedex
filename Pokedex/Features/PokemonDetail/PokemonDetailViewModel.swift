//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 21/06/25.
//

import Foundation

protocol PokemonDetailViewModelDelegate: AnyObject {
    func didLoadPokemonDetail(detail: PokemonDetail, isFavorited: Bool)
    func didFailToLoadDetail(with error: Error)
}


final class PokemonDetailViewModel {
    private let service: PokemonServiceProtocol
    private let url: URL?
    private let repository: FavoritePokemonRepositoryProtocol
    private var currentDetail: PokemonDetail?
    
    weak var delegate: PokemonDetailViewModelDelegate?
    
    init(service: PokemonServiceProtocol = PokemonService(), url: URL?, repository: FavoritePokemonRepositoryProtocol = FavoritePokemonUserDefaultsRepository.shared) {
        self.service = service
        self.url = url
        self.repository = repository
    }
    
    func fetchPokemonDetail() {
        guard let url = url else {
            print("error: no url")
            return
        }
        
        service.fetchPokemonDetail(from: url) { [weak self] result in
            switch result {
            case .success(let detail):
                self?.currentDetail = detail
                self?.delegate?.didLoadPokemonDetail(detail: detail, isFavorited: self?.isFavorited() ?? false)
            case .failure(let error):
                self?.delegate?.didFailToLoadDetail(with: error)
            }
        }
    }
    
    func toggleFavorite() {
        guard let pokemon = currentDetail else { return }
        let name = pokemon.name.lowercased()
        
        if isFavorited() {
            repository.remove(name)
        } else {
            repository.add(name)
        }
        
    }
    
    private func isFavorited() -> Bool {
        guard let pokemon = currentDetail else { return false }
        return repository.contains(pokemon.name.lowercased())
    }
    
}
