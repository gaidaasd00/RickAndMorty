//
//  Episode.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//q

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
