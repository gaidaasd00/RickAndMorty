//
//  LocationTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 30.01.2023.
//

import Foundation

struct LocationTableViewCellViewModel: Hashable, Equatable {
  private let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    var name: String {
        return location.name
    }
    
    var type: String {
        return "Type: "+location.type
    }
    
    var dimension: String {
        return location.dimension
    }
    
    static func == (lhs: LocationTableViewCellViewModel, rhs: LocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(location.id)
        hasher.combine(dimension)
    }
}
