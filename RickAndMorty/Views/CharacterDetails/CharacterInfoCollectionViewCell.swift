//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 12.01.2023.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let id = "CharacterInfoCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray
        contentView.layer.cornerRadius = 8
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: CharacterInfoCollectionViewCellViewModel) {
        
    }
}
