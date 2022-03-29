//
//  FriendCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - FriendCell class declaration
final class FriendCell: UITableViewCell {

    //MARK: - Type properties
    static let reuseIdentifier = "FriendCell"
    
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
        
        if let url = URL(string: friend.avatarImageName) {
            avatarView.configure(url: url)
        }
        
        nameLabel.text = friend.name
        self.completion = completion
    }
    
    func animate() {
        self.avatarView.alpha = 0
        self.frame.origin.x += 400
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.15,
                       options: [],
                       animations: {
            self.avatarView.alpha = 1
        })
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.1,
                       options: [],
                       animations: {
            self.frame.origin.x = 0
        })
    }
    
    //MARK: - Actions
    @IBAction func animatePressButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.7,
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
