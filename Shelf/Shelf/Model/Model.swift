//
//  Model.swift
//  Shelf
//
//  Created by Ronny Aretz on 10/5/19.
//  Copyright © 2019 Ronny Aretz. All rights reserved.
//
import Foundation

extension Array {
    subscript (_ index: UInt) -> Element! {
        return Int(index) < count ? self[Int(index)] : nil
    }
}
extension String {
    subscript(_ i:Int)->Character {
        return self[self.index(self.startIndex, offsetBy:i)] // read-only, so no need for get { }
    }
}

class Model {
    private init() {}
    
    private static var _shared: Model!
    static var shared: Model {
        if _shared == nil {
            _shared = Model()
        }
        return _shared
    }

    public func getCategories() -> Array<Category>{
        return [Category(title:"Syfy"),Category(title:"Fiction")]
    }
    
    public func numRequests() -> Int {
        return requests.count
    }
    
    public var requests  = [ Request(title: "Hunger Games", category: "Sci-fi"), Request(title: "Harry Potter", category: "Fantasy") ]
    
    public var books  = [
        Book(title: "Hunger Games", category: Category(title:"Syfy"), owner: Owner(name: "Max Mustermann", place: Place(state: "MO", city: "Maryville", postalCode: "64468",street: "9 Syfystreet"))),
        Book(title: "Hary Potter", category: Category(title:"Fiction"), owner: Owner(name: "Jon Doe", place: Place(state: "MO", city: "Kansas City", postalCode: "64468",street: "500 Kansasstreet"))) ]
}
