//
//  LocationView.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 26.01.2023.
//

import UIKit

final class LocationView: UIView {

    
    
    private var viewModel: LocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.alpha = 0
        table.isHidden = true
        table.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.id)
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView, spinner)
        spinner.startAnimating()
        addConstraint()
        configureTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 101),
            spinner.widthAnchor.constraint(equalToConstant: 101),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure(with viewModel: LocationViewViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - UITableViewDelegate
extension LocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension LocationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else { fatalError() }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationTableViewCell.id,
            for: indexPath
        ) as? LocationTableViewCell else { fatalError() }
    
        let cellViewModel = cellViewModels[indexPath.row]
        cell.textLabel?.text = cellViewModel.name
        return cell
    }
}
