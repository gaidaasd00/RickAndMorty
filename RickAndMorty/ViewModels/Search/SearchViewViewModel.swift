//
//  SearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 31.01.2023.
//

import Foundation

final class SearchViewViewModel {
    let config: SearchViewController.Config

    private var optionMap: [SearchInputViewViewModel.DynamicOption:String] = [:]
    private var searchText = ""
    private var optionMapUpdateBlock: (((SearchInputViewViewModel.DynamicOption, String)) -> Void)?

    //MARK: - Init
    init(config: SearchViewController.Config) {
        self.config = config
    }
    
    //MARK: - Public
    func executeSearch() {
        
    }
    
    func set(query text: String) {
        self.searchText = text
    }
    
    func set(value: String, for option: SearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    func registerOptionChangeBlock(
        _ block: @escaping ((SearchInputViewViewModel.DynamicOption, String)) -> Void
    ) {
        self.optionMapUpdateBlock = block
    }
}
