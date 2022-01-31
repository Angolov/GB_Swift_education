//
//  Song.swift
//  TSD_lesson6
//
//  Created by Антон Головатый on 30.01.2022.
//

import Foundation
import AVFoundation

//MARK: SongProtocol declaration
protocol SongProtocol {
    
    var albumImageName: String { get set }
    var albumName: String { get set }
    var songName: String { get set }
    var artistName: String { get set }
    var fileExtension: String { get set }
    var songDuration: TimeInterval { get set }
}

//MARK: Song class declaration
final class Song: SongProtocol {
    
    //MARK: - Public properties
    var albumImageName: String
    var albumName: String
    var songName: String
    var artistName: String
    var fileExtension: String
    var songDuration: TimeInterval
    
    //MARK: Initializers
    init(albumImageName: String,
         albumName: String,
         songName: String,
         artistName: String,
         fileExtension: String) {
        
        self.albumImageName = albumImageName
        self.albumName = albumName
        self.songName = songName
        self.artistName = artistName
        self.fileExtension = fileExtension
        
        var player = AVAudioPlayer()
        do {
            if let audioPath = Bundle.main.path(forResource: self.songName, ofType: self.fileExtension) {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            }
        } catch {
            print("init error")
        }
        self.songDuration = player.duration
    }
}


