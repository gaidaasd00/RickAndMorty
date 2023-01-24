//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 29.12.2022.
//

protocol CharacterListViewModelDelegate: AnyObject {
    func didInitialCharacter()
    func didLoadMoreCharacters(with newIndexPath: [IndexPath])
    func didSelectCharacter(_ character: Character)
}

import UIKit

/// View Model to handle character list view logic
final class CharacterListViewModel: NSObject {
    weak var delegate: CharacterListViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [Character] = [] {
        didSet {
            for character in characters {
                let viewModel = CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                if !cellViewModel.contains(viewModel) {
                    cellViewModel.append(viewModel)
                }
            }
        }
    }
    private var cellViewModel: [CharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: GetAllCharacterResponse.Info? = nil
    
    /// Fetch initial set of character(20)
    func fetchCharacter() {
        Service.shared.execute(
            .listCharactersRequests,
            expecting: GetAllCharacterResponse.self
        ) { [weak self] result  in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didInitialCharacter()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        guard let request = Request(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        Service.shared.execute(
            request,
            expecting: GetAllCharacterResponse.self
        ) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(
                    startingIndex..<(startingIndex+newCount)
                ).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.characters.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(
                        with: indexPathsToAdd
                    )
                    
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false
            }
        }
    }
    var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

//MARK: - CollectionView
extension CharacterListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModel.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellId,
            for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(width: cellViewModel[indexPath.row])
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterLoadingCollectionReusableView.id,
                for: indexPath
              ) as? FooterLoadingCollectionReusableView  else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        guard shouldShowLoadMoreIndicator else {return.zero}
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
        
    }
}

//MARK: - ScrollView
extension CharacterListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModel.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewHeights = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewHeights - 120) {
                self?.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}
