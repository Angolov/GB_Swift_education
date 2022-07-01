//
//  PlayerViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class PlayerViewController: UIViewController {
    
    // MARK: - Views
    
    private let imageDownloader = ImageDownloader()
    private let headerView = PlayerHeaderView()
    private let controlsView = PlayerControlsView()
    private let footerView = PlayerFooterView()
    
    // MARK: - Private properties
    
    private let playImageName = "play.fill"
    private let pauseImageName = "pause.fill"
    private let presenter: PlayerViewOutput
    
    var song: ITunesSong?
    
    // MARK: - Initializers
    
    init(presenter: PlayerViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        presenter.viewIsReadyToPlay()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 500),
            
            controlsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            controlsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            controlsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            controlsView.heightAnchor.constraint(equalToConstant: 200),
            
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            footerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            footerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    // MARK: - Private methods
    
    private func configureUI() {
        self.view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(controlsView)
        view.addSubview(footerView)
        
        headerView.hideButton.addTarget(self, action: #selector(hideButtonTapped), for: .touchUpInside)
        controlsView.playbackSlider.addTarget(self, action: #selector(sliderChange), for: .valueChanged)
        controlsView.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        controlsView.previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        controlsView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func hideButtonTapped() {
        presenter.viewDidClosePlayer()
    }
    
    @objc func playButtonTapped() {
        presenter.viewChangedPlayerState()
    }
    
    @objc func sliderChange() {
        let sliderValue = controlsView.playbackSlider.value
        presenter.viewDidSeek(result: sliderValue)
    }

    @objc func previousButtonTapped() {
        presenter.viewDidSelectPreviousSong()
    }

    @objc func nextButtonTapped() {
        presenter.viewDidSelectNextSong()
    }
}

// MARK: - PlayerViewInput

extension PlayerViewController: PlayerViewInput {
    
    func updateData() {
        guard let song = song else { return }
        
        headerView.albumNameLabel.text = song.collectionName
        headerView.songNameLabel.text = song.trackName
        headerView.artistNameLabel.text = song.artistName

        if let artwork = song.artwork,
           let url = URL(string: artwork) {
            imageDownloader.getImage(fromUrl: url) { [weak self] image, error in
                self?.headerView.albumImageView.image = image
            }
        }
        
        controlsView.playbackSlider.value = 0
        controlsView.timeFromStartLabel.text = "00:00"
        controlsView.timeLeftLabel.text = "00:00"
    }
    
    func updateUI(withState state: Bool) {
        let imageName = state ? pauseImageName : playImageName
        let configuration = UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        controlsView.playButton.setImage(image, for: .normal)
    }
    
    func updateControls(withProgressTime progressTime: Float, andSongDuration songDuration: Float) {
        controlsView.playbackSlider.maximumValue = songDuration
        
        let secondsString = String(format: "%02d", Int(Int(progressTime) % 60))
        let minutesString = String(format: "%02d", Int(Int(progressTime) / 60))
        controlsView.timeFromStartLabel.text = "\(minutesString):\(secondsString)"
        controlsView.playbackSlider.value = progressTime
        
        let secondsLeft = songDuration - progressTime
        let secondsLeftString = String(format: "%02d", Int(Int(secondsLeft) % 60))
        let minutesLeftString = String(format: "%02d", Int(Int(secondsLeft) / 60))
        controlsView.timeLeftLabel.text = "\(minutesLeftString):\(secondsLeftString)"
    }
}
