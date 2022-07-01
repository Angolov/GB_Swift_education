//
//  ScreenshotCell.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 24.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class ScreenshotCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var screenshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with image: UIImage?) {
        self.screenshotImageView.image = image
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        self.screenshotImageView.image = nil
    }
    
    private func configureUI() {
        self.addscreenshotImageView()
    }
    
    private func addscreenshotImageView() {
        self.contentView.addSubview(self.screenshotImageView)
        NSLayoutConstraint.activate([
            self.screenshotImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.screenshotImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            self.screenshotImageView.widthAnchor.constraint(equalToConstant: 120),
            self.screenshotImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
