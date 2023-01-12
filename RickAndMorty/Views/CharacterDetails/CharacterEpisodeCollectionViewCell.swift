//
//  CharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 12.01.2023.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let id = "CharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel) {
        
    }
}
