//
//  WhatsNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 23.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class WhatsNewView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var whatsNewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "What's new"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var versionDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var versionDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .right
        return label
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
        self.addSubview(self.whatsNewLabel)
        self.addSubview(self.versionLabel)
        self.addSubview(self.versionDetailsLabel)
        self.addSubview(self.versionDateLabel)
        
        NSLayoutConstraint.activate([
            self.whatsNewLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.whatsNewLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.whatsNewLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            self.versionLabel.topAnchor.constraint(equalTo: self.whatsNewLabel.bottomAnchor, constant: 12.0),
            self.versionLabel.leftAnchor.constraint(equalTo: self.whatsNewLabel.leftAnchor),
            self.versionLabel.widthAnchor.constraint(equalToConstant: 120),
            self.versionDateLabel.topAnchor.constraint(equalTo: self.whatsNewLabel.bottomAnchor, constant: 12.0),
            self.versionDateLabel.rightAnchor.constraint(equalTo: self.whatsNewLabel.rightAnchor),
            self.versionDateLabel.leftAnchor.constraint(equalTo: self.versionLabel.rightAnchor, constant: 12.0),
            self.versionDetailsLabel.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 12.0),
            self.versionDetailsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.versionDetailsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0)
        ])
    }
}
