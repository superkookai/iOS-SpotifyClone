//
//  Album.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 16/6/2564 BE.
//

import Foundation

class Album: Codable{
    
    let name: String
    var followers: Int
    let artist: String
    let image: String
    let songs: [Song]
    
    init(name: String, followers: Int, artist: String, image: String, songs: [Song]){
        self.name = name
        self.followers = followers
        self.artist = artist
        self.image = image
        self.songs = songs
    }
}
