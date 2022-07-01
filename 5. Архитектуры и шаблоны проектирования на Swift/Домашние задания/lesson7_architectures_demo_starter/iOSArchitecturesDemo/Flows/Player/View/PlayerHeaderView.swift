//
//  PlayerHeaderView.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class PlayerHeaderView: UIView {
    
    // MARK: - UI elements
    
    private(set) lazy var hideButton: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.large)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) lazy var albumHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Playing from album"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Album Name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.large)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) lazy var albumView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private(set) lazy var albumImageView: UIImageView = {
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
    private(set) lazy var addToPlaylistButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.large)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Song Name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var optionsButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.large)
        let image = UIImage(systemName: "ellipsis", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addHideButton()
        addShareButton()
        addAlbumHeaderLabel()
        addAlbumNameLabel()
        addAlbumImageView()
        addAddToPlaylistButton()
        addOptionsButton()
        addSongNameLabel()
        addArtistNameLabel()
    }
    
    private func addHideButton() {
        self.addSubview(hideButton)
        
        NSLayoutConstraint.activate([
            hideButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            hideButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            hideButton.heightAnchor.constraint(equalToConstant: 45),
            hideButton.widthAnchor.constraint(equalTo: hideButton.heightAnchor)
        ])
    }
    
    private func addShareButton() {
        self.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            shareButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            shareButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            shareButton.heightAnchor.constraint(equalToConstant: 45),
            shareButton.widthAnchor.constraint(equalTo: hideButton.heightAnchor)
        ])
    }
    
    private func addAlbumHeaderLabel() {
        self.addSubview(albumHeaderLabel)
        
        NSLayoutConstraint.activate([
            albumHeaderLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            albumHeaderLabel.leftAnchor.constraint(equalTo: hideButton.rightAnchor),
            albumHeaderLabel.rightAnchor.constraint(equalTo: shareButton.leftAnchor)
        ])
    }
    
    private func addAlbumNameLabel() {
        self.addSubview(albumNameLabel)
        
        NSLayoutConstraint.activate([
            albumNameLabel.topAnchor.constraint(equalTo: albumHeaderLabel.bottomAnchor, constant: 5),
            albumNameLabel.leftAnchor.constraint(equalTo: hideButton.rightAnchor),
            albumNameLabel.rightAnchor.constraint(equalTo: shareButton.leftAnchor)
        ])
    }
    
    private func addAlbumImageView() {
        albumView.addSubview(albumImageView)
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: albumView.topAnchor),
            albumImageView.leftAnchor.constraint(equalTo: albumView.leftAnchor),
            albumImageView.rightAnchor.constraint(equalTo: albumView.rightAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: albumView.bottomAnchor)
        ])
        
        self.addSubview(albumView)
        
        NSLayoutConstraint.activate([
            albumView.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 20),
            albumView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            albumView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            albumView.heightAnchor.constraint(equalTo: albumView.widthAnchor)
        ])
    }
    
    private func addAddToPlaylistButton() {
        self.addSubview(addToPlaylistButton)
        
        NSLayoutConstraint.activate([
            addToPlaylistButton.topAnchor.constraint(equalTo: albumView.bottomAnchor, constant: 30),
            addToPlaylistButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            addToPlaylistButton.heightAnchor.constraint(equalToConstant: 45),
            addToPlaylistButton.widthAnchor.constraint(equalTo: addToPlaylistButton.heightAnchor)
        ])
    }
    
    private func addOptionsButton() {
        self.addSubview(optionsButton)
        
        NSLayoutConstraint.activate([
            optionsButton.topAnchor.constraint(equalTo: albumView.bottomAnchor, constant: 30),
            optionsButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            optionsButton.heightAnchor.constraint(equalToConstant: 45),
            optionsButton.widthAnchor.constraint(equalTo: optionsButton.heightAnchor)
        ])
    }
    
    private func addSongNameLabel() {
        self.addSubview(songNameLabel)
        
        NSLayoutConstraint.activate([
            songNameLabel.topAnchor.constraint(equalTo: albumView.bottomAnchor, constant: 30),
            songNameLabel.leftAnchor.constraint(equalTo: addToPlaylistButton.rightAnchor),
            songNameLabel.rightAnchor.constraint(equalTo: optionsButton.leftAnchor)
        ])
    }
    
    private func addArtistNameLabel() {
        self.addSubview(artistNameLabel)
        
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 5),
            artistNameLabel.leftAnchor.constraint(equalTo: addToPlaylistButton.rightAnchor),
            artistNameLabel.rightAnchor.constraint(equalTo: optionsButton.leftAnchor)
        ])
    }
}
