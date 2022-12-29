//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 29.12.2022.
//

import UIKit

final class CharacterListViewModel: NSObject {
    func fetchCharacter() {
        Service.shared.execute(.listCharacterRequest, expecting: GetCharacterResponse.self) { result  in
            switch result {
            case .success(let model):
                print("Example image url: "+String(model.results.first?.image ?? "no image"))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension CharacterListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellId,
            for: indexPath) as? CharacterCollectionViewCell else {
           fatalError("Unsupported cell")
       }
        let viewModel = CharacterCollectionViewCellViewModel(
            characterName: "Alex",
            characterStatus: .alive,
            characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
        cell.configure(width: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
}
