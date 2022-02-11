//
//  ProfileFriendViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

class ProfileFriendViewController: UIViewController {
    @IBOutlet weak var friendAvatar: UIImageView!
    @IBOutlet weak var friendCollectionPhoto: UICollectionView!
    @IBOutlet weak var friendName: UILabel!
    
    var friend: FriendModel!
    let identifier = "PhotoCollectionViewCell"
    
    // Данные для галлереи
    
    let cellsCount: CGFloat = 3.0
    let cellsOffset: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendCollectionPhoto.delegate = self
        friendCollectionPhoto.dataSource = self
        
        friendAvatar.image = friend.uiImage
        
        friendCollectionPhoto.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil),
                                       forCellWithReuseIdentifier: identifier)
    }
}
    // MARK: - Table view data source
extension ProfileFriendViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    
    
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.friendsPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.photoImage.image = friend.friendsPhoto[indexPath.item]
        friendName.text = friend?.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        
        let cellWidth = frameCV.width / cellsCount
        let cellHeight = cellWidth
        
        // посчитаем размер ячеек
        let spacing = (cellsCount + 1) * cellsOffset / cellsCount
        return CGSize(width: cellWidth - spacing, height: cellHeight - (cellsOffset * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenPhotoViewController" ) as? FullScreenPhotoViewController else {
            return
        }
        
        vc.photos = friend.friendsPhoto
        vc.indexPath = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
