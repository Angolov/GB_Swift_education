//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 26.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var collecionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    private(set) lazy var songIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "music.note")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        self.titleLabel.text = cellModel.title
        self.subtitleLabel.text = cellModel.subtitle
        self.collecionLabel.text = cellModel.collection
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.subtitleLabel, self.collecionLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addSongIcon()
        self.addTitleLabel()
        self.addSubtitleLabel()
        self.addCollecionLabel()
    }
    
    private func addSongIcon() {
        self.contentView.addSubview(self.songIcon)
        NSLayoutConstraint.activate([
            self.songIcon.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.songIcon.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.songIcon.heightAnchor.constraint(equalToConstant: 52),
            self.songIcon.widthAnchor.constraint(equalToConstant: 52)
            ])
    }
    
    private func addTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.songIcon.rightAnchor, constant: 12.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addSubtitleLabel() {
        self.contentView.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4.0),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.songIcon.rightAnchor, constant: 12.0),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addCollecionLabel() {
        self.contentView.addSubview(self.collecionLabel)
        NSLayoutConstraint.activate([
            self.collecionLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 4.0),
            self.collecionLabel.leftAnchor.constraint(equalTo: self.songIcon.rightAnchor, constant: 12.0),
            self.collecionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
}
