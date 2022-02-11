//
//  CollectionViewCell.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    
    func configure(with image: UIImage) {
        newsImage.image = image
    }
}
