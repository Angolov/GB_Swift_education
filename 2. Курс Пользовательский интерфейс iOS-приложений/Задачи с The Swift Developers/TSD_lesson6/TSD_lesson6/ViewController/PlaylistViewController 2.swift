//
//  PlaylistViewController.swift
//  TSD_lesson6
//
//  Created by Антон Головатый on 30.01.2022.
//

import UIKit

//MARK: - PlaylistViewController class declaration
final class PlaylistViewController: UIViewController {

    //MARK: - Private properties
    private let songViewHeight = 90
    private var currentSongViewPositionY = 100
    private var playList = [SongProtocol]()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playList.append(Song(albumImageName: "Cover",
                             albumName: "Ghost Stories",
                             songName: "A Sky Full Of Stars",
                             artistName: "Coldplay",
                             fileExtension: "mp3"))
        playList.append(Song(albumImageName: "Cover",
                             albumName: "Ghost Stories",
                             songName: "Magic",
                             artistName: "Coldplay",
                             fileExtension: "mp3"))
        
        createSongView(playlist: playList, index: 0)
        createSongView(playlist: playList, index: 1)
    }
    
    //MARK: - Private methods
    private func createSongView(playlist: [SongProtocol]? = nil, index: Int) {
        let newSongView = SongView(frame: CGRect(x: 0,
                                                 y: currentSongViewPositionY,
                                                 width: Int(self.view.frame.width),
                                                 height: songViewHeight))
        currentSongViewPositionY += songViewHeight
        if let playlist = playlist {
            newSongView.configureViewWith(playlist: playlist, songIndex: index, and: self)
        }
        self.view.addSubview(newSongView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == fromPlaylistToPlayerView,
           let destinationController = segue.destination as? PlayerViewController,
              let index = sender as? Int else { return }
        
        destinationController.playList = playList
        destinationController.currentSongIndex = index
    }
}
