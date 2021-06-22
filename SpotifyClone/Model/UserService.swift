//
//  UserService.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 17/6/2564 BE.
//

import Foundation

class UserService{
    
    static let shared = UserService()
    
    private let currentUser = User()
    
    private init(){
        
    }
    
    //Follow Album
    func followAlbum(album: Album){
        if !isFollowingAlbum(album: album){
            currentUser.followingAlbums.append(album.name)
            album.followers += 1
        }
    }
    
    func unFollowAlbum(album: Album){
        if let index = currentUser.followingAlbums.firstIndex(of: album.name){
            currentUser.followingAlbums.remove(at: index)
            album.followers -= 1
        }
    }
    
    func isFollowingAlbum(album: Album) -> Bool{
        return currentUser.followingAlbums.contains(album.name)
    }
    
    
    //Favorite Song
    func favoriteSong(song: Song){
        if !isFavoriteSong(song: song){
            currentUser.favoriteSongs.append(song.title)
        }
    }
    
    func unFavoriteSong(song: Song){
        if let index = currentUser.favoriteSongs.firstIndex(of: song.title){
            currentUser.favoriteSongs.remove(at: index)
        }
    }
    
    func isFavoriteSong(song: Song) -> Bool{
        return currentUser.favoriteSongs.contains(song.title)
    }
}
