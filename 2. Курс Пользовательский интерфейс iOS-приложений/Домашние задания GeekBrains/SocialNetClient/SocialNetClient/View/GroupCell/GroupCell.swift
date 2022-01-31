//
//  GroupCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - GroupCell class declaration
final class GroupCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet var avatarView: AvatarView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        avatarView.configure(image: nil)
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func configure(group: GroupProtocol) {
        avatarView.configure(image: group.avatar)
        nameLabel.text = group.name
        descriptionLabel.text = group.description
    }
}
