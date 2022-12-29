//
//  Location.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

