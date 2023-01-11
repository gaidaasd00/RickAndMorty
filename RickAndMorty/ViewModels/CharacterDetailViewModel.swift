//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 07.01.2023.
//

import Foundation

final class CharacterDetailViewModel {
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    var title: String {
        character.name.uppercased()
    }
}
