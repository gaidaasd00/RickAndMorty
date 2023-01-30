//
//  LocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 26.01.2023.
//

protocol LocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

import Foundation

final class LocationViewViewModel {
    weak var delegate: LocationViewViewModelDelegate?
    
    private var locations: [Location] = [] {
        didSet {
            for location in locations {
                let cellViewModel = LocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    //Location response info
    //will contain next url, if present
    private var apiInfo: GetAllLocationsResponse.Info?

    private(set) var cellViewModels: [LocationTableViewCellViewModel] = []
    
    init() {}
    
    func location(at index: Int) -> Location? {
        guard index < locations.count, index >= 0 else { return nil }
        return self.locations[index]
    }
    
    func fetchLocations() {
        Service.shared.execute(
            .listLocationsRequest,
            expecting: GetAllLocationsResponse.self
        ) { [weak self] results in
            switch results {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    private var hasMoreResults: Bool {
        return false
    }
}
