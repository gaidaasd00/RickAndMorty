//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 07.01.2023.
//

import UIKit

//controller show info single character
final class CharacterDetailViewController: UIViewController {
    private let viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
