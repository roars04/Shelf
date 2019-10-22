//
//  Model.swift
//  Shelf
//
//  Created by Ronny Aretz on 10/5/19.
//  Copyright © 2019 Ronny Aretz. All rights reserved.
//
import Foundation
import UIKit
import CloudKit

extension Array {
    subscript (_ index: UInt) -> Element! {
        return Int(index) < count ? self[Int(index)] : nil
    }
}
extension String {
    subscript (_ i:Int) -> Character {
        return self[self.index(self.startIndex, offsetBy:i)] // read-only, so no need for get { }
    }
}

extension UIViewController {
    
    static func alert(title:String, message:String){
        
        DispatchQueue.main.async {
            let topViewController = UIApplication.shared.keyWindow!.rootViewController!
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            ac.addAction(action)
            topViewController.present(ac, animated:true)
        }
    }
}

class Custodian {
    static var defaultContainer:CKContainer = CKContainer.default()
    static var publicDatabase:CKDatabase = defaultContainer.publicCloudDatabase
    static var privateDatabase:CKDatabase = defaultContainer.privateCloudDatabase
    static var anotherDatabase = CKContainer(identifier: "").publicCloudDatabase
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
    
    subscript(i: Int) -> Request {
        return requests[i]
    }
    
// For requests
    private var requests = [
        Request(bookTitle: "", location: "", city: "", state: "")
    ]
    public var books = [
        Book(title:"Bombay")
    ]
    
    func numRequests() -> Int {
        return requests.count
    }
    
}


/// Models a teacher
class User : Equatable, CKRecordValueProtocol, Hashable {    // need Hashable because we will build a dictionary of
    var record: CKRecord! // this is the only stored property, basically this class is a wrapper class for CKRecord
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
    var email: String {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["email"]!
        }
        set(ssn){
            record["email"] = ssn
        }
    }
    var password: String {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["password"]!
        }
        set(ssn){
            record["password"] = ssn
        }
    }

    var lastName: String{
        get {
            return record["lastName"]!
        }
        
        set(lastName){
            record["lastName"] = lastName
        }
    }
    var firstName: String{
        get {
            return record["firstName"]!
        }
        
        set(firstName){
            record["firstName"] = firstName
        }
    }
    init(record:CKRecord){
        self.record = record
    }
    
    init(email:String,password:String,lastName:String, firstName:String){
        let userRecordId = CKRecord.ID(recordName: "\(email)")                    // 1. create a record ID
        self.record = CKRecord(recordType: "User_Shelf", recordID: userRecordId)  // 2. create a record using that record ID
        self.record["email"] = email
        self.record["lastName"] = lastName
        self.record["password"] = password
        self.email = email
        self.lastName = lastName
        self.firstName = firstName
    }
    
    // Two teachers are deemed equal if they have the same ssn
    static func==(lhs:User,rhs:User)->Bool {
        return lhs.email == rhs.email
    }
    
    /// Adds a teacher to CloudKit *and* locally
    ///
    /// - Parameter user: the user to add to the database
    func add(user:User){
        
        Custodian.publicDatabase.save(user.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a User", message:"\(error)")
            } else {
                //users.append(user)
                UIViewController.alert(title:"Successfully saved user", message:"")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added New User"), object: user)
                    UIViewController.alert(title: "Added New User", message:"")
                }
            }
            
        }
        
    }

}

