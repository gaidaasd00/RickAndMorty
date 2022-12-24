//
//  RMTabBarController.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }
    //MARK: - Private function
    private func setUpViewControllers() {
        let charactersVC = RMCharacterViewController()
        let locationsVC = RMLocationViewController()
        let episodesVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        
        //NavigationItems
        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic

        
        //NavigationBar
        let navigationBar1 = UINavigationController(rootViewController: charactersVC)
        let navigationBar2 = UINavigationController(rootViewController: locationsVC)
        let navigationBar3 = UINavigationController(rootViewController: episodesVC)
        let navigationBar4 = UINavigationController(rootViewController: settingsVC)
        
        //Settings tabBar item
        navigationBar1.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person.and.arrow.left.and.arrow.right"),
            tag: 1
        )
        navigationBar2.tabBarItem = UITabBarItem(
            title: "Locations",
            image: UIImage(systemName: "globe"),
            tag: 2
        )
        navigationBar3.tabBarItem = UITabBarItem(
            title: "Episodes",
            image: UIImage(systemName: "tv"),
            tag: 3
        )
        navigationBar4.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 4
        )
        
        //Settings navigation bar
        for nav in [navigationBar1, navigationBar2, navigationBar3, navigationBar4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [navigationBar1, navigationBar2, navigationBar3, navigationBar4],
            animated: true
        )
    }
}

