//
//  GalleryCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit
import SDWebImage

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
    
    func configure(userPhotos: VKUserPhoto) {
        
        for photo in userPhotos.sizes {
            if photo.type == UIConstants.vkPhotoSizeType,
               let url = URL(string: photo.url) {
                self.photoImageView.sd_setImage(with: url, completed: nil)
                break
            }
        }
        
        currentLikeCount = userPhotos.likes
        let isLiked = userPhotos.isLiked
        likeCounterView.configure(count: currentLikeCount, isLiked: isLiked)
    }
}
