//
//  ProfileTableViewCell.swift
//  MessengerApp
//
//  Created by Антон Головатый on 21.03.2022.
//

import UIKit

//MARK: - ProfileTableViewCell class declaration
class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileTableViewCell"
    
    public func setup(with viewModel: ProfileViewModel) {
        textLabel?.text = viewModel.title
        
        switch viewModel.viewModelType {
        case .info:
            textLabel?.textAlignment = .left
            selectionStyle = .none
            
        case .logout:
            textLabel?.textColor = .red
            textLabel?.textAlignment = .center
        }
    }
}
