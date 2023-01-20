//
//  CharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 12.01.2023.
//

protocol EpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

import Foundation

final class CharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock: ((EpisodeDataRender) -> Void)?
    
    private var episode: Episode? {
        didSet {
            guard let model = episode else { return }
            dataBlock?(model)
        }
    }
    
    
    //MARK: - Init
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    //MARK: - Public
    
    func registerForData(_ block: @escaping (EpisodeDataRender  ) -> Void) {
        self.dataBlock = block
    }
    
    func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
            
        }
        
        guard let url = episodeDataUrl,
              let request = Request(url: url) else {
            return
        }
        isFetching = true
        
        Service.shared.execute(request, expecting: Episode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
        
    }
}
