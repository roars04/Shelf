//
//  Book.swift
//  Shelf
//
//  Created by Ronny Aretz on 10/5/19.
//  Copyright © 2019 Ronny Aretz. All rights reserved.
//

import Foundation

class Book {
    var title: String
    var category: Category
    var owner: Owner
    public init(title:String,category:Category,owner:Owner){
        self.title = title
        self.category = category
        self.owner = owner
    }
}
