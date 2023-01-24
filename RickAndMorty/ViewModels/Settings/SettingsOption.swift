//
//  SettingsOption.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.01.2023.
//

import UIKit

enum SettingsOption: CaseIterable {
    case rate
    case contactUs
    case terms
    case privacy
    case apiLink
    case viewCode
    
    var targetURL: URL? {
        switch self {
        case .rate:
            return nil
        case .contactUs:
            return URL(string: "https://web.telegram.org/k/#@gaidaasd")
        case .terms:
            return URL(string: "https://web.telegram.org/k/#@gaidaasd")
        case .privacy:
            return URL(string: "https://web.telegram.org/k/#@gaidaasd")
        case .apiLink:
            return URL(string: "https://rickandmortyapi.com/")
        case .viewCode:
            return URL(string: "https://github.com/gaidaasd00/RickAndMorty")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rate:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiLink:
            return "API Link"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rate:
            return .systemIndigo
        case .contactUs:
            return .systemCyan
        case .terms:
            return .systemBlue
        case .privacy:
            return .systemPink
        case .apiLink:
            return .systemPurple
        case .viewCode:
            return .systemOrange
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rate:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane.fill")
        case .terms:
            return UIImage(systemName: "doc.fill")
        case .privacy:
            return UIImage(systemName: "lock.fill")
        case .apiLink:
            return UIImage(systemName: "list.clipboard.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}

