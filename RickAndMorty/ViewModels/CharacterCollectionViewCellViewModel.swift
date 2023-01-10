//
//  CharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 29.12.2022.
//

import Foundation

final class CharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    let characterName: String
    private let characterStatus: CharacterStatus
    private let characterImageUrl: URL?
    
   
    //MARK: - Init
    init(characterName: String, characterStatus: CharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
        
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>)-> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    //MARK: - Hashable
    static func == (lhs: CharacterCollectionViewCellViewModel, rhs: CharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
}
