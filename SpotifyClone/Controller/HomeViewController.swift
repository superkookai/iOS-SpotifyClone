//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 16/6/2564 BE.
//

import UIKit

class HomeViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    var categories: [Category]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = CategoryService.shared.categories
        
        navigationController?.isNavigationBarHidden = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumVC = segue.destination as? AlbumViewController, let album = sender as? Album{
            albumVC.album = album
        }
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.row]
        cell.update(category: category, index: indexPath.row)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let categoryIndex = collectionView.tag
        let category = categories[categoryIndex]
        return category.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        let categoryIndex = collectionView.tag
        let category = categories[categoryIndex]
        let album = category.albums[indexPath.row]
        cell.update(album: album)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[collectionView.tag]
        let album = category.albums[indexPath.row]
        performSegue(withIdentifier: "AlbumSegue", sender: album)
    }
}

