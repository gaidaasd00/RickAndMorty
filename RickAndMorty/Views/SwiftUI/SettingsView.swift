//
//  SettingsView.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.01.2023.
//

import SwiftUI

struct SettingsView: View {
    let viewModel: SettingsViewViewModel
    
    init(viewModel: SettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                        .padding(8)
                        .background(Color(viewModel.iconColor))
                        .cornerRadius(6)
                }
                Text(viewModel.title)
                    .padding(.leading, 10)
                    Spacer()     
            }
            .padding(.bottom, 5)
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)    
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .init(cellViewModels: SettingsOption.allCases.compactMap({
            return SettingsCellViewModel(type: $0) { option in
                
            }
        }))
        )
    }
}
