//
//  CharacterStatus.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 29.12.2022.
//

import Foundation

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
