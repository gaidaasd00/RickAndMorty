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
    private var searchResultHandler: (() -> Void)?
    
    //MARK: - Init
    init(config: SearchViewController.Config) {
        self.config = config
    }
    
    //MARK: - Public
    func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    func executeSearch() {
        var queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText)
        ]
        //Add options
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: SearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: "")
        }))
        
        let request = Request(
            endpoint: config.type.endpoint,
            quereParameters: queryParams
        )
        
        Service.shared.execute(request, expecting: GetAllCharacterResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model.results.count))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
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
