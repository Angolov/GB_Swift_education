//
//  MyGroupsViewCell.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class MyGroupsViewCell: UITableViewCell {
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var avatarGroup: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(name: String, image: UIImage?) {
        nameGroup.text = name
        avatarGroup.image = image
    }

}
