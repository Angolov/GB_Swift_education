//
//  FriendGalleryController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit
import RealmSwift

//MARK: - FriendGalleryController class declaration

final class FriendGalleryController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private let adapter = VKServicesAdapter()
    
    let reuseIdentifierGalleryCell = "reuseIdentifierGalleryCell"
    
    var friendIndex = 0
    var userID = 0
    var photos: [UserPhotosViewModel] = []
    
    //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GalleryCell", bundle: nil),
                                forCellWithReuseIdentifier: reuseIdentifierGalleryCell)
        
        adapter.getPhotos(forUser: String(userID)) { [weak self] resultPhotos in
            guard let strongSelf = self else { return }
            let factory = PhotosViewModelFactory()
            strongSelf.photos = factory.constructViewModels(from: resultPhotos)
            strongSelf.collectionView.reloadData()
        }
    }
}
