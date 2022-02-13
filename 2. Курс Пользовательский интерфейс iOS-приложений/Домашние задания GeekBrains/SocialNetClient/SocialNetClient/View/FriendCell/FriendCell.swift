//
//  FriendCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - FriendCell class declaration
final class FriendCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet var avatarView: AvatarView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var completion: (()->Void)?
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        avatarView.configure(image: nil)
        nameLabel.text = nil
        self.completion = nil
    }
    
    func configure(friend: UserProtocol, completion: @escaping ()->Void) {
        avatarView.configure(image: friend.avatar)
        nameLabel.text = friend.name
        self.completion = completion
    }
    
    @IBAction func animatePressButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0,
                       options: []) {[weak self] in
            guard let self = self else { return }
            let currentFrame = self.avatarView.frame
            let newFrame = CGRect(x: currentFrame.origin.x - 10,
                                  y: currentFrame.origin.y,
                                  width: currentFrame.width,
                                  height: currentFrame.height)
            self.avatarView.frame = newFrame
        } completion: {[weak self] _ in
            self?.completion?()
        }
    }
}
