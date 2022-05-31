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
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierGalleryCell,
                                                            for: indexPath) as? GalleryCell
        else { return UICollectionViewCell() }
        cell.configure(userPhotos: photos[indexPath.item])
        return cell
    }
}
