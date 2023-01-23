//
//  EpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 20.01.2023.
//

protocol EpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

import UIKit

final class EpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    private var dataTuple: (episode: Episode, characters: [Character])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModel: [EpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [CharacterCollectionViewCellViewModel])
    }

    weak var delegate: EpisodeDetailViewViewModelDelegate?
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
        
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
        var createdString = episode.created
        if let date = CharacterInfoCollectionViewCellViewModel.dateFormatter.date(
            from: episode.created
        ) {
            createdString = CharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(
                from: date
            ) 
        }
        
        cellViewModels = [
            .information(viewModel: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
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
    /// Fetch episode model
     func fetchEpisodeData() {
         guard let url = endpointUrl, let request = Request(url: url) else {
             return }
         
         Service.shared.execute(request, expecting: Episode.self) { [weak self] result in
             switch result {
             case .success(let model):
                 print(String(describing: model))
                 self?.fetchRelatedCharacter(episode: model)
             case .failure(let failure):
                 print(String(describing: failure))
                 
             }
         }
     }
    
    private func fetchRelatedCharacter(episode: Episode) {
        let requests: [Request] = episode.characters.compactMap({
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
                episode: episode,
                characters: characters
            )
        }
    }
}
