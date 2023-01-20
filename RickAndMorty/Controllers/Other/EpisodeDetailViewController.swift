//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 20.01.2023.
//

import UIKit

/// VC to show details about single episode
final class EpisodeDetailViewController: UIViewController {
    private let viewModel: EpisodeDetailViewViewModel
    
    
    
    //MARK: - Init
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifecycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGray
    }
}
