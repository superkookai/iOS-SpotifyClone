//
//  CategoryCell.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 16/6/2564 BE.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func update(category: Category, index: Int){
        titleLabel.text = category.title
        subtitleLabel.text = category.subtitle
        
        collectionView.tag = index
        collectionView.reloadData()
    }
}
