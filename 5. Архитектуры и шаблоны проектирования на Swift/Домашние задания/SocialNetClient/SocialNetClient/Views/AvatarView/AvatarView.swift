//
//  AvatarView.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit
import SDWebImage

//MARK: - AvatarView class declaration

final class AvatarView: UIView {
    
    //MARK: - Private properties
    
    private var image: UIImage?
    private var imageView = UIImageView()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    //MARK: - Methods
    
    private func setupView() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.7
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = self.bounds
        imageView.layer.cornerRadius = self.bounds.width / 2
        self.layer.cornerRadius = self.bounds.width / 2
    }
    
    func configure(image: UIImage?) {
        imageView.image = image
    }
    
    func configure(url: URL?) {
        imageView.sd_setImage(with: url, completed: nil)
    }
}
