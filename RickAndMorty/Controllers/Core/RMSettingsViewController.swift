//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import StoreKit
import SafariServices
import SwiftUI
import UIKit
/// Controller to show various app options and settings 
final class RMSettingsViewController: UIViewController {
    
    private var settingsSwiftUIController: UIHostingController<SettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addChildSwiftUIController()
    }
    
    private func addChildSwiftUIController() {
        let settingSwiftUIController = UIHostingController(
            rootView: SettingsView(
                viewModel: SettingsViewViewModel(
                    cellViewModels: SettingsOption.allCases.compactMap({
                        return SettingsCellViewModel(type: $0) { [weak self] option in
                            self?.handleTap(option: option)
                        }
                    })
                )))
        addChild(settingSwiftUIController)
        settingSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingSwiftUIController.view)
        settingSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.settingsSwiftUIController = settingSwiftUIController
    }
    
    private func handleTap(option: SettingsOption) {
        guard Thread.current.isMainThread else { return }
        
        if let url = option.targetURL {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rate {
            if let windowScene = self.view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
