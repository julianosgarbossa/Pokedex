//
//  NetworkClient.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import Foundation

// MARK: - ServiceError
enum ServiceError: Error {
    case invalidURL
    case emptyData
}

protocol NetworkClientProtocol {
    func fetch<T: Decodable>(from urlString: String, decodeTo type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkClient: NetworkClientProtocol {
    func fetch<T>(from urlString: String, decodeTo type: T.Type, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ServiceError.emptyData))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
