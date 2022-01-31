//
//  FriendGalleryController+CollectiionDataSource.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - Extension of FriendGalleryController for UICollectionViewDataSource
extension FriendGalleryController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.shared.friends[friendIndex].photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierGalleryCell,
                                                            for: indexPath) as? GalleryCell else { return UICollectionViewCell() }
        cell.configure(friendIndex: friendIndex,
                       photoIndex: indexPath.item) { [weak self] likeCount, isLiked in
            guard let self = self else { return }
            var updatedFriend = Storage.shared.friends[self.friendIndex]
            updatedFriend.likes[indexPath.item] = likeCount
            updatedFriend.isLiked[indexPath.item] = isLiked
            Storage.shared.friends[self.friendIndex] = updatedFriend
        }
        return cell
    }
}
