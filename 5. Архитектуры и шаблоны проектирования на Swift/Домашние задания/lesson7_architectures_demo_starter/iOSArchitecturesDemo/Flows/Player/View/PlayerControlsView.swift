//
//  PlayerControlsView.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class PlayerControlsView: UIView {
    
    // MARK: - UI elements
    
    private(set) lazy var timeFromStartLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var timeLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var playbackSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.thumbTintColor = .green
        slider.tintColor = .green
        slider.isEnabled = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    private(set) lazy var shuffleButton: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.large)
        let image = UIImage(systemName: "shuffle", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) lazy var previousButton: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .ultraLight, scale: .large)
        let image = UIImage(systemName: "backward.end.fill", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)
        let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .ultraLight, scale: .large)
        let image = UIImage(systemName: "forward.end.fill", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) lazy var repeatButton: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.large)
        let image = UIImage(systemName: "repeat", withConfiguration: configuration)
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
        
        addTimeFromStartLabel()
        addTimeLeftLabel()
        addPlaybackSlider()
        addPlayButton()
        addPreviousButton()
        addNextButton()
        addShuffleButton()
        addRepeatButton()
    }
    
    private func addTimeFromStartLabel() {
        self.addSubview(timeFromStartLabel)
        
        NSLayoutConstraint.activate([
            timeFromStartLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            timeFromStartLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20)
        ])
    }
    
    private func addTimeLeftLabel() {
        self.addSubview(timeLeftLabel)
        
        NSLayoutConstraint.activate([
            timeLeftLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            timeLeftLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    private func addPlaybackSlider() {
        self.addSubview(playbackSlider)
        
        NSLayoutConstraint.activate([
            playbackSlider.topAnchor.constraint(equalTo: timeFromStartLabel.bottomAnchor, constant: 5),
            playbackSlider.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            playbackSlider.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    private func addPlayButton() {
        self.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: playbackSlider.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalTo: playButton.heightAnchor)
        ])
    }
    
    private func addPreviousButton() {
        self.addSubview(previousButton)
        
        NSLayoutConstraint.activate([
            previousButton.topAnchor.constraint(equalTo: playbackSlider.bottomAnchor, constant: 20),
            previousButton.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -20),
            previousButton.heightAnchor.constraint(equalToConstant: 60),
            previousButton.widthAnchor.constraint(equalTo: playButton.heightAnchor)
        ])
    }
    
    private func addNextButton() {
        self.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: playbackSlider.bottomAnchor, constant: 20),
            nextButton.leftAnchor.constraint(equalTo: playButton.rightAnchor, constant: 20),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.widthAnchor.constraint(equalTo: playButton.heightAnchor)
        ])
    }
    
    private func addShuffleButton() {
        self.addSubview(shuffleButton)
        
        NSLayoutConstraint.activate([
            shuffleButton.topAnchor.constraint(equalTo: playbackSlider.bottomAnchor, constant: 20),
            shuffleButton.rightAnchor.constraint(equalTo: previousButton.leftAnchor, constant: -10),
            shuffleButton.heightAnchor.constraint(equalToConstant: 60),
            shuffleButton.widthAnchor.constraint(equalTo: playButton.heightAnchor)
        ])
    }
    
    private func addRepeatButton() {
        self.addSubview(repeatButton)
        
        NSLayoutConstraint.activate([
            repeatButton.topAnchor.constraint(equalTo: playbackSlider.bottomAnchor, constant: 20),
            repeatButton.leftAnchor.constraint(equalTo: nextButton.rightAnchor, constant: 10),
            repeatButton.heightAnchor.constraint(equalToConstant: 60),
            repeatButton.widthAnchor.constraint(equalTo: playButton.heightAnchor)
        ])
    }
}
