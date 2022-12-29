//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        Service.shared.execute(.listCharacterRequest, expecting: GetCharacterResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: "+String(model.info.count))
                print("Page results count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
