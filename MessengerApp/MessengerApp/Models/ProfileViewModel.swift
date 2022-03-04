//
//  ProfileViewModel.swift
//  MessengerApp
//
//  Created by Антон Головатый on 04.03.2022.
//

import Foundation

enum ProfileViewModelType {
    case info
    case logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
