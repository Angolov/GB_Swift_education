//
//  AllGroupViewCell.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class AllGroupViewCell: UITableViewCell {
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var avatarGroup: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
