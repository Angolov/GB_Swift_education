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
    private let services = VKServices()
    
    let reuseIdentifierGalleryCell = "reuseIdentifierGalleryCell"
    
    var friendIndex = 0
    var userID = 0
    var photos: [VKUserPhoto] = []
    var photosNames: [String] = []
    var realmPhotoData: List<VKUserPhoto>!
    var token: NotificationToken?
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GalleryCell", bundle: nil),
                                forCellWithReuseIdentifier: reuseIdentifierGalleryCell)
        
        services.fetchVKData(ofType: .photos, withUserId: String(userID))
        pairCollectionAndRealm()
    }
    
    //MARK: - Private methods
    private func pairCollectionAndRealm() {
        guard let realm = try? Realm(),
              let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: String(userID))
        else { return }
        
        realmPhotoData = vkUser.photos
        
        token = realmPhotoData.observe { [weak self] (changes: RealmCollectionChange) in
            guard let strongSelf = self else { return }
            
            switch changes {
            case .initial, .update(_, _, _, _):
                strongSelf.photos = Array(strongSelf.realmPhotoData)
                strongSelf.getPhotoNames()
                strongSelf.collectionView.reloadData()
            
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    private func getPhotoNames() {
        photosNames = []
        for photo in realmPhotoData {
            for size in photo.sizes {
                if size.type == UIConstants.vkPhotoSizeType {
                    photosNames.append(size.url)
                    break
                }
            }
        }
    }
}
