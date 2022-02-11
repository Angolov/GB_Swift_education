//
//  NewsMainViewCell.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class NewsMainViewCell: UITableViewCell {
    @IBOutlet weak var avatarFriend: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    @IBOutlet weak var postData: UILabel!
    @IBOutlet weak var countViews: UIView!
    @IBOutlet weak var textNews: UITextView!
    @IBOutlet weak var colletcionPhoto: UICollectionView!
    
    var collection: [CollectionCellModel] = []
    
    func configure(with model: NewsMainViewCellModel) {
        avatarFriend.image = model.nameFriend.uiImage
        nameFriend.text = model.nameFriend.name
        self.postData.text = model.postDate
        textNews.text = model.postText
        updateCellWith(collection: model.collection)
        colletcionPhoto.dataSource = self
        colletcionPhoto.delegate = self

    }
}

// MARK: Collection view extension

extension NewsMainViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // Обновляем данные для колекции
    func updateCellWith(collection: [CollectionCellModel]) {
        self.collection = collection
        self.colletcionPhoto.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collection.count > 4 {
            return 4
        }else{
            return collection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let collectionCell = collection[indexPath.row]
        cell.configure(with: collectionCell.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
