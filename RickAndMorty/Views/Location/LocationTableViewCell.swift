//
//  LocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 30.01.2023.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {
    static let id = "LocationTableViewCell"
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: LocationTableViewCellViewModel) {
         
    }
}
