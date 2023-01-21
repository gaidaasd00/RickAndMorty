//
//  CharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 12.01.2023.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let id = "CharacterEpisodeCollectionViewCell"
    
    private let seasonLebel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        setUpLayer()
        contentView.addSubviews(seasonLebel, nameLabel, airDateLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            seasonLebel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLebel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            seasonLebel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            seasonLebel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLebel.bottomAnchor),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLebel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.nameLabel.text = data.name
            self?.seasonLebel.text = "Episode: "+data.episode
            self?.airDateLabel.text = "Aired on: "+data.air_date
        }
        viewModel.fetchEpisode()
        contentView.layer.borderColor = viewModel.borderColor.cgColor
    }
    
}
