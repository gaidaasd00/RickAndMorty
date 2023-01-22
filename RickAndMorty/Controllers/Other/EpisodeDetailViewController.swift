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
    private let detailView = EpisodeDetailView()
    
    
    
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
        view.addSubview(detailView)
        setConstraint()
        title = "Episode"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self
            , action: #selector(didTapShared)
        )
    }
    
    @objc func didTapShared() {
        
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
