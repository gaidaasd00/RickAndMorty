//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 29.12.2022.
//

protocol CharacterListViewModelDelegate: AnyObject {
    func didInitialCharacter()
}

import UIKit

final class CharacterListViewModel: NSObject {
    weak var delegate: CharacterListViewModelDelegate?
    
    private var characters: [Character] = [] {
        didSet {
            for character in characters {
                let viewModel = CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                cellViewModel.append(viewModel)
            }
        }
    }
    private var cellViewModel: [CharacterCollectionViewCellViewModel] = []
    
    public func fetchCharacter() {
        Service.shared.execute(
            .listCharacterRequest,
            expecting: GetCharacterResponse.self
        ) { [weak self] result  in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didInitialCharacter()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension CharacterListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellId,
            for: indexPath) as? CharacterCollectionViewCell else {
           fatalError("Unsupported cell")
       }
        cell.configure(width: cellViewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
}
