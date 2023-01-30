//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 30.01.2023.
//

import UIKit

final class LocationDetailViewController: UIViewController, LocationDetailViewViewModelDelegate, LocationDetailViewDelegate {
    private let viewModel: LocationDetailViewViewModel
    private let detailView = LocationDetailView()
    
    //MARK: - Init
    init(location: Location) {
        let url = URL(string: location.url)
        self.viewModel = LocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        detailView.delegate = self
        setConstraint()
        title = "Location"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self
            , action: #selector(didTapShared)
        )
        viewModel.delegate = self
        viewModel.fetchLocationData()
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
    
    //MARK: - View Delegate
    func locationDetailView(_ detailView: LocationDetailView, didSelect character: Character) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - ViewModel Delegate
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
    
}
