//
//  Request.swift
//  Shelf
//
//  Created by Student on 11/22/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Request : Equatable, CKRecordValueProtocol{
    static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.record.recordID == rhs.record.recordID
    }
    
    var record: CKRecord!
    
    var owner: CKRecord.Reference{
        get {
            return record["owner"]!
        }
        set(owner){
            record["owner"] = owner
        }
    }
    
    var requestForBook: CKRecord.Reference{
        get {
            return record["requestForBook"]!
        }
        set(owner){
            record["requestForBook"] = owner
        }
    }
    
    var bookTitle: String{
        get {
            return record["bookTitle"]!
        }
        set(bookTitle){
            record["bookTitle"] = bookTitle
        }
    }
    
    var isbn: String {
        get {
            return record["isbn"]!
        }
        set(isbn){
            record["isbn"] = isbn
        }
    }
    
    var location: String{
        get {
            return record["location"]!
        }
        set(location){
            record["location"] = location
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
    
    var state: String{
        get {
            return record["state"]!
        }
        set(state){
            record["state"] = state
        }
    }
    var countryCode: String?{
        get {
            return record["countryCode"]!
        }
        set(state){
            record["countryCode"] = state
        }
    }
    
    private var date: Date{
        get {
            return record["date"]!
        }
        set(date){
            record["date"] = date
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    init(owner: CKRecord.Reference, requestForBook: CKRecord.Reference, bookTitle: String,isbn: String, location: String, city: String, state: String){
        self.record = CKRecord(recordType: "Request_Shelf")
        self.owner = owner
        self.requestForBook = requestForBook
        self.bookTitle = bookTitle
        self.isbn = isbn
        self.location = location
        self.city = city
        self.state = state
        self.date = Date()
        let locale = NSLocale()
        self.countryCode = locale.countryCode
    }
    
    init(owner: CKRecord.Reference,bookTitle: String, isbn: String, location: String, city: String, state: String) {
        self.record = CKRecord(recordType: "Request_Shelf")
        self.owner = owner
        self.bookTitle = bookTitle
        self.isbn = isbn
        self.location = location
        self.city = city
        self.state = state
        self.date = Date()
        let locale = NSLocale()
        self.countryCode = locale.countryCode
    }
    
    static func add(request:Request){
        Custodian.publicDatabase.save(request.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a Request", message:"\(error)")
            } else {
                
                UIViewController.alert(title:"Successfully saved a Request", message:"")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added a New Request"), object: request)
                    UIViewController.alert(title: "Added a New Request", message:"")
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Added a New Request"),
                                            object: nil)
        }
    }
    
    static func deleteRequest(request:Request){
        Custodian.publicDatabase.delete(withRecordID: request.record.recordID) {
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while deleting a Request", message:"\(error)")
            } else {
                UIViewController.alert(title:"Successfully deleted a Request", message:"")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Deleted a Request"), object: request)
                    UIViewController.alert(title: "Deleted a Request", message:"")
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Deleted a Request"),
                                            object: nil)
        }
    }
    
    func addMyself(){
        Custodian.publicDatabase.save(self.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a Request", message:"\(error)")
            } else {
                UIViewController.alert(title:"Successfully saved a Request", message:"")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added a New Request"), object: self)
                    UIViewController.alert(title: "Added a New Request", message:"")
                }
            }
        }
    }
}

