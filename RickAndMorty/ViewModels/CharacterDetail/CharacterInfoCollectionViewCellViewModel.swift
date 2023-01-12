//
//  CharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 12.01.2023.
//

import Foundation

final class CharacterInfoCollectionViewCellViewModel {
    let value: String
    let title: String
    
    init(value: String, title: String) {
        self.value = value
        self.title = title
    }
}
