//
//  AlbumViewController.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 16/6/2564 BE.
//

import UIKit
import UIImageColors

class AlbumViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    
    var album: Album!
    var albumPrimaryColor: CGColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //For testing purpose
//        album = CategoryService.shared.categories.first?.albums.randomElement()
        
        shuffleButton.layer.cornerRadius = 10.0
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderWidth = 1.0
        
        
        thumbnailImageView.image = UIImage(named: album.image)
        titleLabel.text = album.name
        descriptionLabel.text = "\(album.followers) followers - by \(album.artist)"
        
        if UserService.shared.isFollowingAlbum(album: album){
            followButton.setTitle("Following", for: .normal)
            followButton.layer.borderColor = UIColor(red: 42.0/255.0, green: 183.0/255.0, blue: 89.0/255.0, alpha: 1.0).cgColor
        }else{
            followButton.setTitle("Follow", for: .normal)
            followButton.layer.borderColor = UIColor.white.cgColor
        }
        
        //UIImageColors
        thumbnailImageView.image?.getColors({ (colors) in
            self.albumPrimaryColor = colors!.primary.withAlphaComponent(0.8).cgColor
            self.updateBackground(with: self.albumPrimaryColor)
        })
        
    }
    
    func updateBackground(with color: CGColor){
        let backGroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [backGroundColor,backGroundColor]
        gradientLayer.locations = [0.0,0.4]
        
        let gradientChangeColor = CABasicAnimation(keyPath: "colors")
        gradientChangeColor.duration = 0.5
        gradientChangeColor.toValue = [color,backGroundColor]
        gradientChangeColor.isRemovedOnCompletion = false
        gradientChangeColor.fillMode = .forwards
        
        gradientLayer.add(gradientChangeColor, forKey: "colorChange")
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func followButtonDidTapped(_ sender: UIButton) {
        if UserService.shared.isFollowingAlbum(album: album){
            //unfollow album
            UserService.shared.unFollowAlbum(album: album)
            followButton.setTitle("Follow", for: .normal)
            followButton.layer.borderColor = UIColor.white.cgColor
        }else{
            //follow album
            UserService.shared.followAlbum(album: album)
            followButton.setTitle("Following", for: .normal)
            followButton.layer.borderColor = UIColor(red: 42.0/255.0, green: 183.0/255.0, blue: 89.0/255.0, alpha: 1.0).cgColor
        }
        descriptionLabel.text = "\(album.followers) followers - by \(album.artist)"
    }
    
    @IBAction func backButtonDidTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shuffleButtonDidTapped(_ sender: UIButton) {
        let randomIndex = Int.random(in: 0..<album.songs.count)
        performSegue(withIdentifier: "SongSegue", sender: randomIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let songVC = segue.destination as? SongViewController, let selectedSongIndex = sender as? Int{
            songVC.album = album
            songVC.selectedSongIndex = selectedSongIndex
            songVC.albumPrimaryColor = albumPrimaryColor
        }
    }
    
}

extension AlbumViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        let song = album.songs[indexPath.row]
        cell.update(song: song)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SongSegue", sender: indexPath.row)
    }
}
