//
//  GetCharacterResponse.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 29.12.2022.
//

import Foundation

struct GetAllCharacterResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [Character]
}
