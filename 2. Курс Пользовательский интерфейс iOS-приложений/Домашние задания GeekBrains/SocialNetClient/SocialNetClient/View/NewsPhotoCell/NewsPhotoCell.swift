//
//  NewsPhotoCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import UIKit

//MARK: - NewsPhotoCell class declaration
final class NewsPhotoCell: UICollectionViewCell {
   
    //MARK: - Type properties
    static let reuseIdentifier = "NewsPhotoCell"
    
    //MARK: - UI elements
    private var newsImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - Private methods
    private func setupView() {
        self.contentView.backgroundColor = .red
        newsImageView.frame = self.contentView.frame
        self.contentView.addSubview(newsImageView)
    }
    
    //MARK: - Public methods
    func configure(with image: UIImage) {
        newsImageView.image = image
    }
}
