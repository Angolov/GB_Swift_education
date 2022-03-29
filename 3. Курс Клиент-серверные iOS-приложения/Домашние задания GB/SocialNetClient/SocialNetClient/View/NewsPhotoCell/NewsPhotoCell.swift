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
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }
    
    //MARK: - Private methods
    private func setupView() {
        //self.contentView.backgroundColor = .red
        newsImageView.frame = self.contentView.bounds
        self.contentView.addSubview(newsImageView)
    }
    
    //MARK: - Public methods
    func configure(with image: UIImage, isForthItem: Bool, counter: Int) {
        newsImageView.image = image
        
        if isForthItem {
            let label = UILabel()
            label.frame = newsImageView.bounds
            label.font = .systemFont(ofSize: 40, weight: .bold)
            label.textColor = .white
            label.textAlignment = .center
            label.text = "+\(counter - 3)"
            
            let view = UIView()
            view.frame = newsImageView.bounds
            view.backgroundColor = .black
            view.alpha = 0.7
            
            newsImageView.addSubview(view)
            newsImageView.addSubview(label)
        }
    }
}
