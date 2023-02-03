//
//  SearchInputView.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 31.01.2023.
//

protocol SearchInputViewDelegate: AnyObject {
    func searchInputView(
        _ inputView: SearchInputView,
        didSelectOption option: SearchInputViewViewModel.DynamicOption
    )
}

import UIKit

final class SearchInputView: UIView {
    weak var delegate: SearchInputViewDelegate?
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = "Search"
        return search
    }()
    
    private var viewModel: SearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {return}
            let options = viewModel.options
            createOptionsSelectionView(options: options)
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(searchBar)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        return stackView
    }
    
    private func createOptionsSelectionView(options: [SearchInputViewViewModel.DynamicOption]) {
        let stackView = createOptionStackView()
        for x in 0..<options.count {
            let option = options[x]
            let button = createButton(with: option, tag: x)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(
        with option: SearchInputViewViewModel.DynamicOption,
        tag: Int
    ) -> UIButton {
        
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(
                string: option.rawValue,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                    .foregroundColor: UIColor.label
                ]
            ),
            for: .normal
        )
        button.setTitle(option.rawValue, for: .normal)
        button.backgroundColor = .secondarySystemFill
        button.setTitleColor(.label, for: .normal)
        button.addTarget(
            self, action: #selector(didTapButton(_:)),
            for: .touchUpInside
        )
        button.tag = tag
        button.layer.cornerRadius = 6
        
        return button
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else { return }
        let tag = sender.tag
        let selected = options[tag]
        
        delegate?.searchInputView(self, didSelectOption: selected)       
    }
    
    //MARK: - Public
    func configure(with viewModel: SearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    func presentKeyboard() {
        searchBar.becomeFirstResponder()  
    }
}
