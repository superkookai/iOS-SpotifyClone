//
//  CategoryService.swift
//  SpotifyClone
//
//  Created by Weerawut Chaiyasomboon on 16/6/2564 BE.
//

import Foundation

class CategoryService{
    
    let categories: [Category]
    
    static let shared = CategoryService()
    
    private init(){
        let categoriesURL = Bundle.main.url(forResource: "categories", withExtension: "json")!
        let data = try! Data(contentsOf: categoriesURL)
        let decoder = JSONDecoder()
        categories = try! decoder.decode([Category].self, from: data)
        
    }
    
    
}
