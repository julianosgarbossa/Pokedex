//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 21/06/25.
//

import Foundation

protocol PokemonDetailViewModelDelegate: AnyObject {
    func didLoadPokemonDetail(detail: PokemonDetail)
    func didFailToLoadDetail(with error: Error)
}


final class PokemonDetailViewModel {
    private let service: PokemonServiceProtocol
    private let url: URL?
    
    weak var delegate: PokemonDetailViewModelDelegate?
    
    init(service: PokemonServiceProtocol = PokemonService(), url: URL?) {
        self.service = service
        self.url = url
    }
    
    func fetchPokemonDetail() {
        guard let url = url else {
            print("error: no url")
            return
        }
        
        service.fetchPokemonDetail(from: url) { [weak self] result in
            switch result {
            case .success(let detail):
                self?.delegate?.didLoadPokemonDetail(detail: detail)
            case .failure(let error):
                self?.delegate?.didFailToLoadDetail(with: error)
            }
        }
    }
}
