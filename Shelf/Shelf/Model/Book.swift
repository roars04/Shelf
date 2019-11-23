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
    
    
}
