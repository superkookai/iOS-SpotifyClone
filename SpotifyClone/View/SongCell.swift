//
//  SongCell.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 16/6/2564 BE.
//

import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    func update(song: Song){
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }
}
