//
//  AlbumCell.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 16/6/2564 BE.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func update(album: Album){
        titleLabel.text = album.name
        artistLabel.text = album.artist
        thumbnailImageView.image = UIImage(named: album.image)
    }
}
