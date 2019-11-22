//
//  User.swift
//  Shelf
//
//  Created by Student on 11/22/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

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
    var city: String{
        get {
            return record["city"]!
        }
        
        set(city){
            record["city"] = city
        }
    }
    var street: String{
        get {
            return record["street"]!
        }
        
        set(street){
            record["street"] = street
        }
    }
    var state: String{
        get {
            return record["state"]!
        }
        
        set(state){
            record["state"] = state
        }
    }
    var postal: String{
        get {
            return record["postal"]!
        }
        
        set(postal){
            record["postal"] = postal
        }
    }
    var phone: String{
        get {
            return record["phone"]!
        }
        
        set(phone){
            record["phone"] = phone
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    init(email:String,password:String,lastName:String, firstName:String,city:String,street:String,state:String,postal:String,phone:String){
        let userRecordId = CKRecord.ID(recordName: "\(email)")                    // 1. create a record ID
        self.record = CKRecord(recordType: "User_Shelf", recordID: userRecordId)  // 2. create a record using that record ID
        self.record["email"] = email
        self.record["lastName"] = lastName
        self.record["password"] = password
        self.email = email
        self.lastName = lastName
        self.firstName = firstName
        self.city = city
        self.postal = postal
        self.state = state
        self.street = street
        self.phone = phone
    }
    
    // Two teachers are deemed equal if they have the same ssn
    static func==(lhs:User,rhs:User)->Bool {
        return lhs.email == rhs.email
    }
}
