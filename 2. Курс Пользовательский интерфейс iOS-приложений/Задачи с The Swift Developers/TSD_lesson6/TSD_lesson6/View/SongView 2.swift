//
//  SongView.swift
//  TSD_lesson6
//
//  Created by Антон Головатый on 30.01.2022.
//

import UIKit

//MARK: - SongView class declaration
final class SongView: UIView {

    //MARK: - Outlets
    @IBOutlet weak var viewImageView: UIView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songDurationLabel: UILabel!
    
    //MARK: - Private properties
    private var song: SongProtocol!
    private var songIndex: Int!
    private weak var viewController: UIViewController!
    private var view: UIView!
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - Private methods
    private func loadFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "SongView", bundle: bundle)
        guard let view = xib.instantiate(withOwner: self, options: nil).first as? UIView else { return UIView() }
        return view
    }
    
    private func setupView() {
        self.view = loadFromXib()
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewImageView.layer.shadowRadius = 10
        viewImageView.layer.shadowOpacity = 0.7
        viewImageView.layer.shadowColor = UIColor.black.cgColor
        viewImageView.layer.shadowOffset = CGSize(width: 2, height: 5)
        self.addSubview(view)
    }
    
    //MARK: - Public methods
    func configureViewWith(playlist: [SongProtocol], songIndex: Int, and viewController: UIViewController) {
        self.song = playlist[songIndex]
        self.songIndex = songIndex
        self.viewController = viewController
        songNameLabel.text = song.songName + "." + song.fileExtension
        let formatter = DateComponentsFormatter()
        songDurationLabel.text = formatter.string(from: song.songDuration)
        if let songImage = UIImage(named: song.albumImageName) {
            songImageView.image = songImage
        }
    }
    
    //MARK: - Actions
    @IBAction func songViewPressed(_ sender: UIButton) {
        self.viewController.performSegue(withIdentifier: fromPlaylistToPlayerView, sender: self.songIndex)
    }
}
