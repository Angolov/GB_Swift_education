//
//  FriendsViewCell.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

class FriendsViewCell: UITableViewCell {
    @IBOutlet weak var avatarFriend: CastomAvatarImage!
    @IBOutlet weak var nameFriend: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // c кофигурируем нашу ячейку
    func configure(name: String, image: UIImage) {
        nameFriend.text = name
        avatarFriend.image = image
        animate()
    }
    
    // запускаем анимацию ячейки при появлении
    func animate() {
        self.avatarFriend.alpha = 0
        self.frame.origin.x += 200
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.15,
                       options: [],
                       animations: {
            self.avatarFriend.alpha = 1
        })
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.1,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
            self.frame.origin.x = 0
        })
    }
}
