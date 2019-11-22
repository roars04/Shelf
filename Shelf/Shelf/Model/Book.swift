//
//  Book.swift
//  Shelf
//
//  Created by Student on 11/22/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Book : Equatable, CKRecordValueProtocol{
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.record.recordID == rhs.record.recordID
    }
    
    var record: CKRecord!
    
    var isbn: String {
        get {
            return record["isbn"]!
        }
        set(isbn){
            record["isbn"] = isbn
        }
    }
    
    var title: String {
        get {
            return record["title"]!
        }
        set(title){
            record["title"] = title
        }
    }
    
    var description: String{
        get {
            return record["description"]!
        }
        set(description){
            record["description"] = description
        }
    }
    
    var author: String{
        get {
            return record["author"]!
        }
        set(author){
            record["author"] = author
        }
    }
    
    var illustrator: String{
        get {
            return record["illustrator"]!
        }
        set(illustrator){
            record["illustrator"] = illustrator
        }
    }
    
    var coverArtist: String{
        get {
            return record["coverArtist"]!
        }
        set(coverArtist){
            record["coverArtist"] = coverArtist
        }
    }
    
    var countryCode: String?{
        get {
            return record["countryCode"]!
        }
        set(countryCode){
            record["countryCode"] = countryCode
        }
    }
    
    var language: String{
        get {
            return record["language"]!
        }
        set(language){
            record["firstName"] = language
        }
    }
    
    var category: String{
        get {
            return record["category"]!
        }
        set(genre){
            record["category"] = genre
        }
    }
    
    var publisher: String{
        get {
            return record["publisher"]!
        }
        set(publisher){
            record["publisher"] = publisher
        }
    }
    
    var publicationDate: Date{
        get {
            return record["publicationDate"]!
        }
        set(publicationDate){
            record["publicationDate"] = publicationDate
        }
    }
    
    var pages: Int{
        get {
            return record["pages"]!
        }
        set(pages){
            record["pages"] = pages
        }
    }
    var owner: CKRecord.Reference!{
        get {
            return record["owner"]!
        }
        set(owner){
            record["owner"] = owner
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    init(owner:CKRecord.Reference,isbn: String, title: String, description: String, author: String, illustrator: String, coverArtist: String, country: String, language: String, category: String, publisher: String, publicationDate: Date, pages: Int){
        
        self.record = CKRecord(recordType: "Book_Shelf")
        self.owner = owner
        self.isbn = isbn
        self.title = title
        self.description = description
        self.author = author
        self.illustrator = illustrator
        self.coverArtist = coverArtist
        let locale = NSLocale()
        self.countryCode = locale.countryCode
        self.category = category
        self.publisher = publisher
        self.publicationDate = publicationDate
        self.pages = pages
        self.language = language
    }
    
    static func add(book:Book){
        Custodian.publicDatabase.save(book.record){
            (record, error) in
            if let error = error {
                NotificationCenter.default.post(name: NSNotification.Name("Error with New Book"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("Added a New Book"), object: nil)
            }
        }
    }
    
    func addMyself(){
        Custodian.publicDatabase.save(self.record){
            (record, error) in
            if let error = error {
                NotificationCenter.default.post(name: NSNotification.Name("Error with New Book"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("Added a New Book"), object: nil)
            }
        }
    }
    
    static func getAllBooksOfUser(user:User){
        
        let predicate = NSPredicate(format: "owner == %@", Model.shared.LoggedInUser!.record.recordID)
        let query = CKQuery(recordType: "Book_Shelf", predicate: predicate)
        Custodian.publicDatabase.perform(query, inZoneWith: nil){
            (bookR, error) in
            if let error = error {
                UIViewController.alert(title: "Problem getting a Book", message:"\(error)")
                return
            }
            Model.shared.myBooks = []
            if let bookR = bookR {
                for bookRecord in bookR {
                    let book = Book(record:bookRecord)
                    Model.shared.myBooks.append(book)
                }
            }
            Model.shared.booksOfAUser = [:]
            if let bookR = bookR {
                for bookRecord in bookR {
                    let book = Book(record:bookRecord)
                    Model.shared.booksOfAUser[book.title] = book
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllBooksOfAUser Fetched"),
                                            object: nil)
        }
    }
    
    static func getAllBooksOfCategory(category:String){
        //here we need something like group by
        let predicate = NSPredicate(format: "category == %@", category)
        let query = CKQuery(recordType: "Book_Shelf", predicate: predicate)
        Custodian.publicDatabase.perform(query, inZoneWith: nil){
            (bookRecords, error) in
            if let error = error {
                UIViewController.alert(title: "Problem getting a Book", message:"\(error)")
                return
            }
            Model.shared.books = []
            if let bookRecords = bookRecords {
                for bookRecord in bookRecords {
                    let book = Book(record:bookRecord)
                    Model.shared.books.append(book)
                }
            }
            Model.shared.booksOfACategory = [:]
            if let bookRecords = bookRecords {
                for bookRecord in bookRecords {
                    let book = Book(record:bookRecord)
                    Model.shared.booksOfACategory[book.isbn] = book
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllBooksOfACategory Fetched"),
                                            object: nil)
        }
    }
    
    static func getAllOwnerOfABook(isbn:String){
        var owner:[CKRecord.ID] = []
        for book in Model.shared.books{
            if book.isbn == isbn {
                owner.append(book.owner.recordID)
            }
        }
        Model.shared.fetchOwner = GetAllOwnerOfBooksFetchHelper(ownerIDs: owner)
    }
}
