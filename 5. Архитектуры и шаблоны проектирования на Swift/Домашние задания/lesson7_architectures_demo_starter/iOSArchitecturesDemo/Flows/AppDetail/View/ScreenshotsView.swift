//
//  ScreenshotsView.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 24.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class ScreenshotsView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var screenshotsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Screenshots"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayout()
    }
    
    // MARK: - UI
    
    private func setupLayout() {
        self.addSubview(self.screenshotsLabel)
        self.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.screenshotsLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 3.0),
            self.screenshotsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.screenshotsLabel.heightAnchor.constraint(equalToConstant: 26),
            self.collectionView.topAnchor.constraint(equalTo: self.screenshotsLabel.bottomAnchor, constant: 3.0),
            self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3.0),
            self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3.0),
            self.collectionView.heightAnchor.constraint(equalToConstant: 130.0)
        ])
    }
}
