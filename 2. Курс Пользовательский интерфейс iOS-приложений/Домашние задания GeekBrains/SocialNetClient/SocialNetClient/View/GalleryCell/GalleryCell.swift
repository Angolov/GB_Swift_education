//
//  GalleryCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - GalleryCell class declaration
final class GalleryCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var likeCounterView: LikeControlView!
    
    //MARK: - Private properties
    private var currentLikeCount = 0
    private var doAfterLike: ((Int, Bool) -> Void)?
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    func configure(friendIndex: Int,
                   photoIndex: Int,
                   completion: @escaping (Int, Bool) -> Void) {
        photoImageView.image = Storage.shared.friends[friendIndex].photos[photoIndex]
        currentLikeCount = Storage.shared.friends[friendIndex].likes[photoIndex]
        let isLiked = Storage.shared.friends[friendIndex].isLiked[photoIndex]
        likeCounterView.configure(count: currentLikeCount,
                                  isLiked: isLiked,
                                  completion: completion)
    }
}
