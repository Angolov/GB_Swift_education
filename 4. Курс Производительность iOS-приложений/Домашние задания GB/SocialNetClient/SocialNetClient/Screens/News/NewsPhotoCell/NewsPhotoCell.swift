//
//  NewsPhotoCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 05.05.2022.
//

import UIKit

//MARK: - NewsPhotoCell class declaration
final class NewsPhotoCell: UITableViewCell {

    //MARK: - Type properties
    static let reuseIdentifier = "NewsPhotoCell"
    
    //MARK: - UI elements
    lazy private var photoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    //MARK: - Public properties
    func configure(with photoName: String) {
        
        setupView()
        if let url = URL(string: photoName) {
            photoImageView.sd_setImage(with: url)
        }
    }
    
    //MARK: - Private properties
    private func setupView() {
        
        self.contentView.addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
}
