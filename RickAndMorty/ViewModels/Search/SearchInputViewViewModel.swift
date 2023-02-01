//
//  SearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 31.01.2023.
//

import Foundation

final class SearchInputViewViewModel {
    private let type: SearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    //MARK: - Init
    init(type: SearchViewController.Config.`Type`) {
        self.type = type
    }
    
    //MARK: - Public
    var hasDynamicOptions: Bool {
        switch self.type {
        case .character:
            return true
        case .episode:
            return false
        case .location:
            return true
        }
    }
    
    var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .episode:
            return []
        case .location:
            return [.locationType]
        }
    }
    
    var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .episode:
            return "Episode Title"
        case .location:
            return "Location Name"
        }
    }
}
