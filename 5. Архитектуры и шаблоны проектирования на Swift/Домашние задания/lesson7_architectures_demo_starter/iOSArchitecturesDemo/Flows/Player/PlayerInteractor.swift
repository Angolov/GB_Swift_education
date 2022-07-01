//
//  PlayerInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import AVFoundation

protocol PlayerInteractorInput {
    func play(song: ITunesSong, completion: @escaping (_ progress: Float, _ duration: Float) -> Void)
    func changeState(toState state: Bool)
    func seek(value: Float)
    func stop()
}

final class PlayerInteractor: PlayerInteractorInput {
    
    // MARK: - Properties
    
    private var player = AVPlayer()
    private var isPlaying = false
    private var timeObserverToken: Any!
    
    // MARK: - Public methods
    
    func play(song: ITunesSong, completion: @escaping (_ progress: Float, _ duration: Float) -> Void) {
        removePeriodicTimeObserverIfNeccessary()
        
        if let previewUrl = song.previewUrl,
           let url = URL(string: previewUrl) {
            player = AVPlayer(url: url)
        }
        
        player.play()
        isPlaying = true
        
        let interval = CMTime(value: 1, timescale: 2)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: nil) { [weak self] progressTime in
            guard let strongSelf = self,
                  let duration = strongSelf.player.currentItem?.duration else { return }
            
            let timeFromStart = Float(CMTimeGetSeconds(progressTime))
            let songDuration = Float(CMTimeGetSeconds(duration))
            completion(timeFromStart, songDuration)
        }
    }
    
    func changeState(toState state: Bool) {
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    func seek(value: Float) {
        player.seek(to: CMTime(value: CMTimeValue(value), timescale: 1))
    }
    
    func stop() {
        isPlaying = false
        player.pause()
        removePeriodicTimeObserverIfNeccessary()
    }
    
    // MARK: - Private methods
    
    private func removePeriodicTimeObserverIfNeccessary() {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
}
