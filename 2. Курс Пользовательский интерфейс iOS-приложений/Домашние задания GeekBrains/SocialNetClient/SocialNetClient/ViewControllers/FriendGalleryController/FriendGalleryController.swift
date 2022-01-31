//
//  FriendGalleryController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - FriendGalleryController class declaration
final class FriendGalleryController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: - Properties
    let reuseIdentifierGalleryCell = "reuseIdentifierGalleryCell"
    var friendIndex = 0
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GalleryCell", bundle: nil),
                                forCellWithReuseIdentifier: reuseIdentifierGalleryCell)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    
}
