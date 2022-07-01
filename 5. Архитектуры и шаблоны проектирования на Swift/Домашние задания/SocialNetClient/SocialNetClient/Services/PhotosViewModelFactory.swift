//
//  PhotosViewModelFactory.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 05.06.2022.
//

import Foundation

//MARK: PhotosViewModelFactory class declaration

final class PhotosViewModelFactory {
    
    func constructViewModels(from userPhotos: [UserPhoto]) -> [UserPhotosViewModel] {
        return userPhotos.compactMap(self.viewModel)
    }
    
    private func viewModel(from userPhoto: UserPhoto) -> UserPhotosViewModel {
        var photoName = ""
        for size in userPhoto.sizes {
            if size.type == UIConstants.vkPhotoSizeType {
                photoName = size.url
                break
            }
        }
        let imageURL = URL(string: photoName)!
        let isLiked = userPhoto.isLiked
        let likes = userPhoto.likes
        
        return UserPhotosViewModel(imageURL: imageURL, isLiked: isLiked, likes: likes)
    }
}
