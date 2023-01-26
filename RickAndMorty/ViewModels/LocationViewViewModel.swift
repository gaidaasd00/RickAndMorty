//
//  LocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 26.01.2023.
//

import Foundation

final class LocationViewViewModel {
    
    private var locations: [LocationView] = []
    
    //Location response info
    //will contain next url, if present
    private var cellViewModels: [String] = []
    
    private var hasMoreResults: Bool {
        return false
    }
    
    
    init() {}
    
    func fetchLocations() {
        Service.shared.execute(.listLocationsRequest, expecting: String.self) { results in
            switch results {
            case .success(let model):
                break
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
