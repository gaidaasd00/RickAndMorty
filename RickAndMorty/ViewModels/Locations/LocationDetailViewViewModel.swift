//
//  LocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 30.01.2023.
//

protocol LocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

import UIKit

final class LocationDetailViewViewModel {
    private let endpointUrl: URL?
    private var dataTuple: (location: Location, characters: [Character])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    enum SectionType {
        case information(viewModel: [EpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [CharacterCollectionViewCellViewModel])
    }

    weak var delegate: LocationDetailViewViewModelDelegate?
    private(set) var cellViewModels: [SectionType] = []
    
    //MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    func character(at index: Int) -> Character? {
        guard let dataTuple = dataTuple else {return nil}
        return dataTuple.characters[index]
    }
    
    //MARK: = Private
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = location.created
        if let date = CharacterInfoCollectionViewCellViewModel.dateFormatter.date(
            from: location.created
        ) {
            createdString = CharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(
                from: date
            )
        }
        
        cellViewModels = [
            .information(viewModel: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: createdString),
            ]),
            .characters(viewModel: characters.compactMap({
                return CharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image)
                )
            }))
        ]
    }
    /// Fetch location model
     func fetchLocationData() {
         guard let url = endpointUrl, let request = Request(url: url) else {
             return }
         
         Service.shared.execute(request, expecting: Location.self) { [weak self] result in
             switch result {
             case .success(let model):
                 print(String(describing: model))
                 self?.fetchRelatedCharacter(location: model)
             case .failure(let failure):
                 print(String(describing: failure))
                 
             }
         }
     }
    
    private func fetchRelatedCharacter(location: Location) {
        let requests: [Request] = location.residents.compactMap({
            return URL(string: $0)
        }) .compactMap ({
            Request(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [Character] = []
        
        for request in requests {
            group.enter() //+1
            Service.shared.execute(request, expecting: Character.self) { result in
                defer {
                    group.leave() //-1
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (
                location: location,
                characters: characters
            )
        }
    }
}
