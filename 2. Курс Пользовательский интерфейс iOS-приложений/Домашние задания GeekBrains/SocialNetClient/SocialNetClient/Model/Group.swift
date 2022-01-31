//
//  Group.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import Foundation
import UIKit

//MARK: - GroupProtocol declaration
protocol GroupProtocol {
    
    var name: String { get set }
    var avatar: UIImage { get set }
    var avatarImageName: String { get set }
    var description: String { get set }
}

//MARK: - Group struct declaration
struct Group: GroupProtocol {
    
    var name: String
    var avatar: UIImage
    var avatarImageName: String
    var description: String
}
