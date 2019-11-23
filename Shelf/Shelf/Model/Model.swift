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
    public var myRequests:[Request] = []
    public var requestsRecieved:[Request] = []
    public var userOfRequest: User?
    public var books:[Book] = []
    public var myBooks:[Book] = []
    public var booksOfAUser:[String:Book] = [:]
    public var booksOfACategory:[String:Book] = [:]
    
    public var ownerOfABook:[User] = []
    
    public var LoggedInUser : User!
    
    public var categories:[String] = [
        "Action and Adventure", "Anthology", "Classic", "Comic and Graphic Novel", "Crime and Detective", "Drama", "Fable", "Fairy Tale", "Fan Fiction", "Fantasy", "Historical Fiction", "Horror", "Humor", "Legend", "Magical Realism", "Mystery", "Mythology", "Realistic Fiction", "Romance", "Satire", "Science Fiction", "Short Story", "Suspense Thriller", "Biography Autobiography", "Essay", "Memoir", "Narrative Nonfiction", "Periodicals", "Reference", "Self help", "Speech", "Textbook", "Poetry"
    ]
    
    var fetchOwner:GetAllOwnerOfBooksFetchHelper? = nil
    var fetchRequest:GetAllRequestsOfLoggedInUserFetchHelper? = nil
    
    func numMyRequests() -> Int {
        return myRequests.count
    }
    func numRequestsRecieved() -> Int {
        return requestsRecieved.count
    }
    func deleteRequest(index:Int) {
        Model.shared.deleteRequest(request: myRequests[index])
        myRequests.remove(at: index)
    }
    func deleteReceivedRequest(index:Int) {
        Model.shared.deleteRequest(request: requestsRecieved[index])
        requestsRecieved.remove(at: index)
    }
    func numBooks() -> Int {
        return booksOfACategory.count
    }
    
    func sha256(data : Data) -> Data {
        let hash = [UInt8](repeating: 0,  count: 10)
        return Data(hash)
    }
    
    func Login(username:String, Password:String) -> Void {
        
        let predicate = NSPredicate(format:"email = %@ AND password = %@",username,Password)
        let query = CKQuery(recordType: "User_Shelf", predicate: predicate)
        // this gets *all * teachers
        var isValid = false;
        Custodian.publicDatabase.perform(query, inZoneWith: nil){
            (userrecord, error) in
            if let error = error {
                //self.alert(title: "Disaster while fetching all teachers:", message: "\(error)")
                UIViewController.alert(title: "Invalid Credentials", message:"\(error)")
                isValid = false;
            } else {
                // note the studentRecord -> student
                if(userrecord!.count>0){
                    let userDetails = User(record: userrecord![0])
                    self.LoggedInUser = userDetails
                    isValid = true;
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Login Sucess"), object: nil)
                }
                else{
                    UIViewController.alert(title: "Invalid Credentials", message:"Please enter valid Credentials")
                    isValid = false;
                }
            }
        }
        //return isValid;
    }
    /// Adds a User to CloudKit *and* locally
    ///
    /// - Parameter user: the user to add to the database
    func addAUser(user:User){
        
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
    func addABook(book:Book){
        Custodian.publicDatabase.save(book.record){
            (record, error) in
            if error != nil {
                NotificationCenter.default.post(name: NSNotification.Name("Error with New Book"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("Added a New Book"), object: nil)
            }
        }
    }
    
    func getAllBooksOfUser(user:User){
        
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
    
    func getAllBooksOfCategory(category:String){
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
    
    func getAllOwnerOfABook(isbn:String){
        var owner:[CKRecord.ID] = []
        for book in Model.shared.books{
            if book.isbn == isbn {
                owner.append(book.owner.recordID)
            }
        }
        Model.shared.fetchOwner = GetAllOwnerOfBooksFetchHelper(ownerIDs: owner)
    }
    func addARequest(request:Request){
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
    
    func deleteRequest(request:Request){
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
    
    func deleteBook(book:Book){
        Custodian.publicDatabase.delete(withRecordID: book.record.recordID) {
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while deleting a Book", message:"\(error)")
            } else {
                UIViewController.alert(title:"Successfully deleted a Book", message:"")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Deleted a Book"), object: book)
                    UIViewController.alert(title: "Deleted a Book", message:"")
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Deleted a Book"),
                                            object: nil)
        }
    }
}


class GetAllOwnerOfBooksFetchHelper{
    var ownerIDs:[CKRecord.ID]
    var count:Int = 0
    var result:[User] = []
    private let counterQueue = DispatchQueue(label: "AtomicCounterQueue", attributes: .concurrent)
    
    init(ownerIDs:[CKRecord.ID]) {
        self.ownerIDs = ownerIDs
        fetchAllOwnerOfABook()
    }
    func increment(){
        self.counterQueue.async(flags:.barrier) {
            self.count += 1
            if self.count == self.ownerIDs.count {
                Model.shared.ownerOfABook = self.result
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllOwnerOfABook Fetched"),
                                                object: nil)
            }
        }
    }
    
    func fetchAllOwnerOfABook(){
        for owner in ownerIDs{
            Custodian.publicDatabase.fetch(withRecordID: owner, completionHandler: {
                (userRecord, error) in
                if error != nil {
                    self.increment()
                    return
                }
                self.result.append(User(record: userRecord!))
                self.increment()
            })
        }
        
    }
}



class GetAllRequestsOfLoggedInUserFetchHelper{
    var count:Int = 0
    private let counterQueue = DispatchQueue(label: "AtomicCounterQueue", attributes: .concurrent)
    
    init() {
        fetchAllBooksOfLoggedInUser()
    }

    func increment(){
        self.counterQueue.async(flags:.barrier) {
            self.count += 1
            if self.count == 1{
                self.fetchAllRequestsOfLoggedInUser()
            }
            else if self.count == 3{
                NotificationCenter.default.post(name: NSNotification.Name("Fetched allData"),
                object: nil)
            }
        }
    }
    
    func fetchAllBooksOfLoggedInUser(){
        let bookPredicate = NSPredicate(format: "owner == %@", Model.shared.LoggedInUser!.record.recordID)
        let bookQuery = CKQuery(recordType: "Book_Shelf", predicate: bookPredicate)
        Custodian.publicDatabase.perform(bookQuery, inZoneWith: nil){
            (bookR, error) in
            if error != nil {
                self.increment()
                return
            }
            Model.shared.myBooks = []
            if let bookR = bookR {
                for bookRecord in bookR {
                    Model.shared.myBooks.append(Book(record:bookRecord))
                }
            }
            self.increment()
        }
    }
    
    func fetchAllRequestsOfLoggedInUser(){
        Model.shared.requestsRecieved = []
        let getAllRequestPredicate = NSPredicate(value:true)
        let getAllRequestQuery = CKQuery(recordType: "Request_Shelf", predicate: getAllRequestPredicate)
        Custodian.publicDatabase.perform(getAllRequestQuery, inZoneWith: nil){
            (requestRecords, error) in
            if error != nil {
                self.increment()
                return
            }
            if let requestRecords = requestRecords {
                for requestRecord in requestRecords {
                    let request = Request(record:requestRecord)
                    for book in Model.shared.myBooks {
                        if book.isbn == request.isbn {
                            if request.owner == Model.shared.LoggedInUser.record.recordID {
                                
                            } else {
                                Model.shared.requestsRecieved.append(request)
                            }
                        }
                    }
                }
            }
            self.increment()
        }
        Model.shared.myRequests = []
        let myRequestsPredicate = NSPredicate(format: "owner == %@", Model.shared.LoggedInUser!.record.recordID)
        let myRequestsQuery = CKQuery(recordType: "Request_Shelf", predicate: myRequestsPredicate)
        Custodian.publicDatabase.perform(myRequestsQuery, inZoneWith: nil){
            (requestRecords, error) in
            if error != nil {
                self.increment()
                return
            }
            if let requestRecords = requestRecords {
                for requestRecord in requestRecords {
                    let request = Request(record:requestRecord)
                    Model.shared.myRequests.append(request)
                }
            }
            self.increment()
        }
    }
}
