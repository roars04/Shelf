//
//  Requests.swift
//  Shelf
//
//  Created by Student on 10/4/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

struct Request {
    var title: String
    var category: String
}

class Requests {
    private init() {}
    
    private static var _shared: Requests!
    static var shared: Requests {
        if _shared == nil {
            _shared = Requests()
        }
        return _shared
    }
    subscript(i: Int) -> Request {
        return requests[i]
    }
    
    func numRequests() -> Int {
        return requests.count
    }
    
    private var requests  = [ Request(title: "Hunger Games", category: "Sci-fi"), Request(title: "Harry Potter", category: "Fantasy") ]
}
