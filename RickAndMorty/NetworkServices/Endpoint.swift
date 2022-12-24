//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import Foundation

/// Represent unique API endpoint
@frozen enum Endpoint: String {
   /// Endpoint get character info
    case character
    /// Endpoint get location info
    case location
    /// Endpoint get episode info
    case episode
}
