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
            
    }
}
