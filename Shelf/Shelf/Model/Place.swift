//
//  Place.swift
//  Shelf
//
//  Created by Ronny Aretz on 10/5/19.
//  Copyright © 2019 Ronny Aretz. All rights reserved.
//

import Foundation

class Place{
    var state: String
    var city: String
    var postalCode: String
    var street: String
    
    public init(state: String, city: String, postalCode: String,street: String){
        self.state = state
        self.city = city
        self.postalCode = postalCode
        self.street = street
    }
}
