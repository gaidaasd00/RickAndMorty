//
//  Service.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import Foundation

/// Primary Api service object to get Rick and Morty data
final class Service {
    /// Shared singleton
    static let shared = Service()
    
    /// Private constructor
    private init() {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - expecting: The type object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping(Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData ))
                return
            }
            //Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    //MARK: - Private
    private func request(from rmRequest: Request) -> URLRequest? {
        guard let url = rmRequest.url else { return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
    
}
