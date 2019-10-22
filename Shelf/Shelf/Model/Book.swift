//
//  Book.swift
//  Shelf
//
//  Created by Ronny Aretz on 10/5/19.
//  Copyright © 2019 Ronny Aretz. All rights reserved.
//

import Foundation

struct Book {
    var title: String
    var owner: User
    public init(title:String){
        self.title = title
        owner = User(name:"Test")
    }
}
