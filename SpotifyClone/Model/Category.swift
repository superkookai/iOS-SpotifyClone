//
//  Category.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 16/6/2564 BE.
//

import Foundation

class Category: Codable{
    let title: String
    let subtitle: String
    let albums: [Album]
    
    init(title: String, subtitle: String, albums: [Album]){
        self.title = title
        self.subtitle = subtitle
        self.albums = albums
    }
}
