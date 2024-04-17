//
//  NetworkManager.swift
//  WishList
//
//  Created by 김정호 on 4/17/24.
//

import Foundation

final class NetworkManager {
    
    // MARK: - properties
    static let shared = NetworkManager()
    private init() { }
    
    let url = "https://dummyjson.com/products/"
    
    // MARK: - methods
    func fetchProduct(id: Int, completion: @escaping ((Result<ProductDTO, Error>) -> Void)) {
        guard let url = URL(string: "\(self.url)/\(id)") else {
            completion(.failure(NetworkError.urlConversionFailure))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            do {
                let product = try JSONDecoder().decode(ProductDTO.self, from: data)
                completion(.success(product))
            } catch {
                completion(.failure(NetworkError.jsonDecodingFailure))
            }
        }
        
        task.resume()
    }
    
    func fetchUrlImage(url: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.urlConversionFailure))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
