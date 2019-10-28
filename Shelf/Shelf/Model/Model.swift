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
    
    // For requests
    public var requests:[Request] = [
        //Request(owner: CKRecord.ID(recordName: "Request_Shelf") ,bookTitle: "", location: "", city: "", state: "")
    ]
    
    public var books:[Book] = [
        //Book(owner:CKRecord.ID(recordName: "Book_Shelf"),isbn: "234655435", title: "Bombay", description: "bla", author: "John Doe", illustrator: "John Doe", coverArtist: "John Doe", country: "USA", language: "English", genre: "Fantasy", publisher: "Book Publisher", publicationDate: Date(timeIntervalSince1970: 435243252), pages: 100)
    ]
    public var booksOfACategory:[String:Book] = [:
        //Book(owner:CKRecord.ID(recordName: "Book_Shelf"),isbn: "234655435", title: "Bombay", description: "bla", author: "John Doe", illustrator: "John Doe", coverArtist: "John Doe", country: "USA", language: "English", genre: "Fantasy", publisher: "Book Publisher", publicationDate: Date(timeIntervalSince1970: 435243252), pages: 100)
    ]
    public var ownerOfABook:[User] = []
    
    public var users:[User] = []
    
    enum categories:String {
        case Action_and_Adventure, Anthology, Classic, Comic_and_Graphic_Novel, Crime_and_Detective, Drama, Fable, Fairy_Tale, Fan_Fiction, Fantasy, Historical_Fiction, Horror, Humor, Legend, Magical_Realism, Mystery, Mythology, Realistic_Fiction, Romance, Satire, Science_Fiction, Short_Story, Suspense_Thriller, Biography_Autobiography, Essay, Memoir, Narrative_Nonfiction, Periodicals, Reference, Self_help, Speech, Textbook, Poetry
    }
    
    
    func numRequests() -> Int {
        return requests.count
    }
    func numBooks() -> Int {
        return booksOfACategory.count
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
    var owner: CKRecord.ID{
        get {
            return record["owner"]! as! CKRecord.ID
        }
        set(owner){
            record["owner"] = owner as! __CKRecordObjCValue
        }
    }

    init(record:CKRecord){
        self.record = record
    }

    init(owner:CKRecord.ID,isbn: String, title: String, description: String, author: String, illustrator: String, coverArtist: String, country: String, language: String, category: String, publisher: String, publicationDate: Date, pages: Int){
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
    convenience init(owner:User, isbn: String, title: String, description: String, author: String, illustrator: String, coverArtist: String, country: String, language: String, category: String, publisher: String, publicationDate: Date, pages: Int,countryCode:String){
        self.init(owner:owner ,isbn: isbn, title: title, description: description, author: author, illustrator: illustrator, coverArtist: coverArtist, country: country, language: language, category: category, publisher: publisher, publicationDate: publicationDate, pages: pages,countryCode:countryCode)
    }

    static func add(book:Book){
        Custodian.publicDatabase.save(book.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a Book", message:"\(error)")
            } else {
                UIViewController.alert(title:"Successfully saved a Book", message:"")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added a New Book"), object: book)
                    UIViewController.alert(title: "Added a New Book", message:"")
                }
            }
        }
    }

    func addMyself(){
        Custodian.publicDatabase.save(self.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a Book", message:"\(error)")
            } else {
                UIViewController.alert(title:"Successfully saved a Book", message:"")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added a New Book"), object: self)
                    UIViewController.alert(title: "Added a New Book", message:"")
                }
            }
        }
    }
    
    func getAllBooksOfCategory(category:Category, tableView:UITableView){
        //here we need something like group by
        let predicate = NSPredicate(format: "category == %@", category)
        let query = CKQuery(recordType: "Book_Shelf", predicate: predicate)
        Custodian.publicDatabase.perform(query, inZoneWith: nil){
            (bookRecords, error) in
            if let error = error {
                UIViewController.alert(title: "fetchAllBooksOfACategory() problem getting a Book", message:"\(error)")
                return
            }
            Model.shared.booksOfACategory = [:]
            if let bookRecords = bookRecords {
                for bookRecord in bookRecords {
                    let book = Book(record:bookRecord)
                    Model.shared.booksOfACategory[book.isbn] = book
                }
            }
            DispatchQueue.main.async { tableView.reloadData()}
        }
    }
    func getAllBooksOfISBN(isbn:String, tableView:UITableView){
        let predicate = NSPredicate(format: "isbn == %@", isbn)
        let query = CKQuery(recordType: "Book_Shelf", predicate: predicate)
        Custodian.publicDatabase.perform(query, inZoneWith: nil){
            (bookRecords, error) in
            if let error = error {
                UIViewController.alert(title: "fetchAllBooksOfISBN() problem getting a Book", message:"\(error)")
                return
            }
            Model.shared.booksOfACategory = [:]
            if let bookRecords = bookRecords {
                for bookRecord in bookRecords {
                    let book = Book(record:bookRecord)
                    Model.shared.books.append(book)
                }
            }
            DispatchQueue.main.async { tableView.reloadData()}
        }
    }

    func getAllOwnerOfABook(book:Book, tableView:UITableView){

    }
    
        
}


class Request : Equatable, CKRecordValueProtocol{
    static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.record.recordID == rhs.record.recordID
    }

    var record: CKRecord!

    var owner: CKRecord.ID{
        get {
            return record["owner"]! as! CKRecord.ID
        }
        set(owner){
            record["owner"] = owner as! __CKRecordObjCValue
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
    
    init(owner: CKRecord.ID,bookTitle: String, location: String, city: String, state: String) {
        self.record = CKRecord(recordType: "Request_Shelf")
        self.owner = owner
        self.bookTitle = bookTitle
        self.location = location
        self.city = city
        self.state = state
        self.date = Date()
        let locale = NSLocale()
        self.countryCode = locale.countryCode
    }
    
    convenience init(owner: CKRecord,bookTitle: String, location: String, city: String, state: String) {
        self.init(owner: owner.recordID,bookTitle: bookTitle, location: location, city: city, state: state)
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
    func getAllRequestsOfAOwner(owner: CKRecord.ID, tableView:UITableView){
        //here we need something like group by
        let predicate = NSPredicate(format: "id == %@", owner)
        let query = CKQuery(recordType: "Request_Shelf", predicate: predicate)
        Custodian.publicDatabase.perform(query, inZoneWith: nil){
            (requestRecords, error) in
            if let error = error {
                UIViewController.alert(title: "fetchAllRequestsOfAOwner() problem getting a Request", message:"\(error)")
                return
            }
            Model.shared.booksOfACategory = [:]
            if let requestRecords = requestRecords {
                for requestRecord in requestRecords {
                    let request = Request(record:requestRecord)
                    Model.shared.requests.append(request)
                }
            }
            DispatchQueue.main.async { tableView.reloadData()}
        }
    }
}
