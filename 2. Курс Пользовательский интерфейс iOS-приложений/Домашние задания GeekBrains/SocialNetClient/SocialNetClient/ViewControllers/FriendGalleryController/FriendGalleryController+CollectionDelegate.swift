//
//  FriendGalleryController+CollectionDelegate.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - Extension of FriendGalleryController for UICollectionViewDelegate
extension FriendGalleryController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoViewController = PhotoViewController()
        photoViewController.configure(images: Storage.shared.friends[friendIndex].photos,
                                      index: indexPath.item)
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }
}
