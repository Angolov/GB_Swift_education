//
//  PlayerPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol PlayerViewInput: class {
    var song: ITunesSong? { get set }
    func updateData()
    func updateControls(withProgressTime progressTime: Float, andSongDuration songDuration: Float)
    func updateUI(withState state: Bool)
}

protocol PlayerViewOutput: class {
    func viewIsReadyToPlay()
    func viewDidClosePlayer()
    func viewChangedPlayerState()
    func viewDidSelectNextSong()
    func viewDidSelectPreviousSong()
    func viewDidSeek(result value: Float)
}

// MARK: - PlayerPresenter

final class PlayerPresenter {
    
    weak var viewInput: (UIViewController & PlayerViewInput)?
    
    // MARK: - Private properties
    
    private let interactor: PlayerInteractorInput
    private let router: PlayerRouterInput
    
    private let playList: [ITunesSong]
    private var currentSongIndex: Int
    private var isPlaying = false
    
    // MARK: - Initializer
    
    init(songs: [ITunesSong], index: Int, router: PlayerRouterInput, interactor: PlayerInteractorInput) {
        playList = songs
        currentSongIndex = index
        
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Private methods
    
    private func startPlaying() {
        if isPlaying {
            isPlaying.toggle()
            interactor.changeState(toState: isPlaying)
        }
        
        let song = playList[currentSongIndex]
        isPlaying.toggle()
        
        viewInput?.song = song
        viewInput?.updateData()
        viewInput?.updateUI(withState: isPlaying)
        
        interactor.play(song: song) { [weak self] progress, duration in
            self?.viewInput?.updateControls(withProgressTime: progress, andSongDuration: duration)
        }
    }
}

// MARK: - PlayerViewOutput

extension PlayerPresenter: PlayerViewOutput {
    func viewIsReadyToPlay() {
        startPlaying()
    }
    
    func viewChangedPlayerState() {
        isPlaying.toggle()
        interactor.changeState(toState: isPlaying)
        viewInput?.updateUI(withState: isPlaying)
    }
    
    func viewDidSelectNextSong() {
        guard currentSongIndex < playList.count - 1 else { return }
        currentSongIndex += 1
        startPlaying()
    }
    
    func viewDidSelectPreviousSong() {
        guard currentSongIndex > 0 else { return }
        currentSongIndex -= 1
        startPlaying()
    }
    
    func viewDidSeek(result value: Float) {
        interactor.seek(value: value)
    }
    
    func viewDidClosePlayer() {
        router.closePlayer()
    }
}
