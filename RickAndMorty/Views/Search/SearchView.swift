//
//  SearchView.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 31.01.2023.
//

protocol SearchViewDelegate: AnyObject {
    func searchView(
        _ searchView: SearchView,
        didSelectOption option: SearchInputViewViewModel.DynamicOption
    )
}

import UIKit

final class SearchView: UIView {
    weak var delegate: SearchViewDelegate?
    
    private let viewModel: SearchViewViewModel
    
    //MARK: - Subviews
    private let searchInputView = SearchInputView()
    private let noResultsView = NoSearchResultsView()
    
    //MARK: - Init
    init(frame: CGRect, viewModel: SearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView, searchInputView)
        addConstraints()
        
        searchInputView.configure(with: .init(type: viewModel.config.type))
        searchInputView.delegate = self
        
        viewModel.registerOptionChangeBlock { tuple in
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            //Input view
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(
                equalToConstant: viewModel.config.type == .episode ? 55 : 110
            ),
            //No results view
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
}
    //MARK: - CollectionViewDelegate
extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - SearchInputViewDelegate
extension SearchView: SearchInputViewDelegate {
    func searchInputView(
        _ inputView: SearchInputView,
        didSelectOption option: SearchInputViewViewModel.DynamicOption
    ) {
        delegate?.searchView(self, didSelectOption: option)
    }
    
    func searchInputView(_ inputView: SearchInputView, didChangeSearchText text: String) {
        viewModel.set(query: text)
    }
    
    func searchInputViewDidTapSearchKeyboardButton(_ inputView: SearchInputView) {
        viewModel.executeSearch()
    }
}

