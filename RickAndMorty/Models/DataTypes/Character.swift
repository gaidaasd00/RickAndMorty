//
//  Character.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import Foundation
struct Character: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: Origin
    let location: SingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
