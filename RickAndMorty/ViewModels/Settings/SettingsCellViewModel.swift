//
//  SettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.01.2023.
//

import UIKit

struct SettingsCellViewModel: Identifiable {
    
    let id = UUID()
    let type: SettingsOption
    
    let onTapHandler: (SettingsOption) -> Void
    
    
    //MARK: - Init
    init(type: SettingsOption, onTapHandler: @escaping (SettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    //MARK: - Public
    var image: UIImage? {
        type.iconImage
    }
    
    var title: String {
        type.displayTitle
    }
    
    var iconColor: UIColor {
        type.iconContainerColor
    }
    
    //MARK: - Private
    
}
