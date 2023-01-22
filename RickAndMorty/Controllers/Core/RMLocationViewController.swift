//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import UIKit

/// Controller to show and search for locations
final class RMLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Locations"
        addSearchButton()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearch)
        )
    }
    
    @objc func didTapSearch() {
        
    }

}
