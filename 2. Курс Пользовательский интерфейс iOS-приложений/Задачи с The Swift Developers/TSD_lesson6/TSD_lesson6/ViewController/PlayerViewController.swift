//
//  PlayerViewController.swift
//  TSD_lesson6
//
//  Created by Антон Головатый on 30.01.2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var viewImageView: UIView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var timeFromStartLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var playButtonLabel: UIButton!
    @IBOutlet weak var playbackSlider: UISlider!
    
    //MARK: - Private properties
    private let playImageName = "play.fill"
    private let pauseImageName = "pause.fill"
    private var isPlaying = false
    private var timeObserverToken: Any!
    
    //MARK: - Public properties
    var player = AVPlayer()
    var playList: [SongProtocol]!
    var currentSongIndex: Int!
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        play(playList[currentSongIndex])
    }
    
    //MARK: - Private methods
    private func configureView() {
        viewImageView.layer.cornerRadius = 15
        viewImageView.layer.shadowRadius = 10
        viewImageView.layer.shadowColor = UIColor.black.cgColor
        viewImageView.layer.shadowOpacity = 0.7
        viewImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        albumImageView.layer.cornerRadius = 15
        playbackSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        playbackSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .highlighted)
        playbackSlider.value = 0
        playbackSlider.addTarget(self, action: #selector(sliderChange), for: .valueChanged)
        
        updateViewInformationWith(song: playList[currentSongIndex])
    }
    
    private func updateViewInformationWith(song: SongProtocol) {
        if let image = UIImage(named: song.albumImageName) {
            albumImageView.image = image
        }
        albumNameLabel.text = song.albumName
        songNameLabel.text = song.songName
        artistNameLabel.text = song.artistName
        playbackSlider.maximumValue = Float(song.songDuration)
        
        let dateFormatter = DateComponentsFormatter()
        timeLeftLabel.text = dateFormatter.string(from: song.songDuration)
        timeFromStartLabel.text = "00:00"
    }
    
    private func play(_ song: SongProtocol) {
        
        if let audioPath = Bundle.main.path(forResource: song.songName, ofType: song.fileExtension) {
                player = AVPlayer(url: URL(fileURLWithPath: audioPath))
        }
        self.player.play()
        isPlaying = true
        playButtonLabel.setImage(UIImage(systemName: pauseImageName), for: .normal)
        
        let interval = CMTime(value: 1, timescale: 2)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval,
                                       queue: nil) { [weak self] progressTime in
            guard let self = self,
                  let duration = self.player.currentItem?.duration else { return }
            
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(Int(seconds) % 60))
            let minutesString = String(format: "%02d", Int(Int(seconds) / 60))
            
            self.timeFromStartLabel.text = "\(minutesString):\(secondsString)"
            self.playbackSlider.value = Float(seconds)
            
            let secondsLeft = CMTimeGetSeconds(duration) - seconds
            let secondsLeftString = String(format: "%02d", Int(Int(secondsLeft) % 60))
            let minutesLeftString = String(format: "%02d", Int(Int(secondsLeft) / 60))
            
            self.timeLeftLabel.text = "\(minutesLeftString):\(secondsLeftString)"
        }
    }
    
    private func removePeriodicTimeObserver() {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    
    @objc func sliderChange(sender: UISlider) {
        if sender == playbackSlider {
            player.seek(to: CMTime(value: CMTimeValue(sender.value), timescale: 1))
        }
    }
    
    //MARK: - Actions
    @IBAction func playButtonPressed(_ sender: Any) {
        if isPlaying {
            self.player.pause()
            playButtonLabel.setImage(UIImage(systemName: playImageName), for: .normal)
        } else {
            self.player.play()
            playButtonLabel.setImage(UIImage(systemName: pauseImageName ), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        guard currentSongIndex < playList.count - 1 else { return }
        removePeriodicTimeObserver()
        player.pause()
        currentSongIndex += 1
        updateViewInformationWith(song: playList[currentSongIndex])
        play(playList[currentSongIndex])
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        guard currentSongIndex > 0 else { return }
        removePeriodicTimeObserver()
        player.pause()
        currentSongIndex -= 1
        updateViewInformationWith(song: playList[currentSongIndex])
        play(playList[currentSongIndex])
    }
    
    @IBAction func hideButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        print("share button pressed")
        let items = ["\(playList[currentSongIndex].songName)"]
        let uiActivityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(uiActivityController, animated: true, completion: nil)
    }
}
