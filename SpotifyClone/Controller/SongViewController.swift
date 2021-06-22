//
//  SongViewController.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 20/6/2564 BE.
//

import UIKit

class SongViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var album: Album!
    var selectedSongIndex: Int!
    var albumPrimaryColor: CGColor!
    var userStartedSliding = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        //Data for testing
//        album = CategoryService.shared.categories.randomElement()!.albums.randomElement()
//        albumPrimaryColor = UIColor.blue.cgColor
//        selectedSongIndex = 0
        
        //Add gradient to background
        let backgroundColor = view.backgroundColor!.cgColor
        let gredientLayer = CAGradientLayer()
        gredientLayer.frame = view.frame
        gredientLayer.colors = [albumPrimaryColor!,backgroundColor]
        gredientLayer.locations = [0.0,0.4]
        view.layer.insertSublayer(gredientLayer, at: 0)
        
        thumbnailImageView.image = UIImage(named: "\(album.image)-lg")
        trackSlider.value = 0
        currentTimeLabel.text = "00:00"
        playButton.layer.cornerRadius = playButton.frame.size.width / 2.0
        
        playSelectedSong()
        
        AudioService.shared.delegate = self
        
        updateFavoriteButton()
    }
    
    private func playSelectedSong(){
        let songSelected = album.songs[selectedSongIndex]
        titleLabel.text = songSelected.title
        artistLabel.text = songSelected.artist
        AudioService.shared.play(song: songSelected)
    }
    
    func updateFavoriteButton(){
        let selectedSong = album.songs[selectedSongIndex]
        if UserService.shared.isFavoriteSong(song: selectedSong){
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    @IBAction func favoriteButtonDidTapped(_ sender: UIButton) {
        let selectedSong = album.songs[selectedSongIndex]
        if UserService.shared.isFavoriteSong(song: selectedSong){
            UserService.shared.unFavoriteSong(song: selectedSong)
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }else{
            UserService.shared.favoriteSong(song: selectedSong)
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        }
    }
    
    @IBAction func sliderValueDidChanged(_ sender: UISlider) {
        if sender.isContinuous{
            userStartedSliding = true
            sender.isContinuous = false
        }else{
            userStartedSliding = false
            AudioService.shared.play(atTime: Double(sender.value))
            sender.isContinuous = true
        }
    }
    
    @IBAction func previousButtonDidTapped(_ sender: UIButton) {
        selectedSongIndex = max(0, selectedSongIndex - 1)
        playSelectedSong()
        updateFavoriteButton()
    }
    
    @IBAction func playButtonDidTapped(_ sender: UIButton) {
        //if tag = 0, pause music
        let TAG_PAUSE = 0
        let TAG_PLAY = 1
        
        if sender.tag == TAG_PAUSE{
            AudioService.shared.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
            sender.tag = TAG_PLAY
        }else if sender.tag == TAG_PLAY{
            AudioService.shared.resume()
            sender.setImage(UIImage(named: "pause"), for: .normal)
            sender.tag = TAG_PAUSE
        }
    }
    
    @IBAction func nextButtonDidTapped(_ sender: UIButton) {
        selectedSongIndex = (selectedSongIndex + 1) % album.songs.count
        playSelectedSong()
        updateFavoriteButton()
    }
    
    @IBAction func dismissButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        AudioService.shared.pause()
    }
}

extension SongViewController: AudioServiceDelegate{
    
    func songIsPlaying(currentTime: Double, duration: Double) {
        trackSlider.maximumValue = Float(duration)
        
        if !userStartedSliding{
            trackSlider.value = Float(currentTime)
        }
        
        currentTimeLabel.text = stringFromTime(time: currentTime)
        durationLabel.text = stringFromTime(time: duration)
    }
    
    func stringFromTime(time: Double) -> String{
        let seconds = Int(time) % 60
        let minutes = (Int(time) / 60) % 60
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
   
}
