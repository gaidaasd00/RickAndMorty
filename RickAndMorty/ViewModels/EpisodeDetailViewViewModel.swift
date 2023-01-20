//
//  EpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 20.01.2023.
//

import Foundation

final class EpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    private func fetchEpisodeData() {
        guard let url = endpointUrl, let request = Request(url: url) else {
            return }
        
        Service.shared.execute(request, expecting: Episode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
                
            }
        }
    }
}
