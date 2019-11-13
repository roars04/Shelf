//
//  AddBookViewController.swift
//  Shelf
//
//  Created by student on 10/5/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CloudKit

class AddBookViewController: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var isbnTF: UITextField!
    @IBOutlet weak var authorTF: UITextField!
    @IBOutlet weak var publisherTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var illustratorTF: UITextField!
    @IBOutlet weak var pagesTF: UITextField!
    @IBOutlet weak var coverArtistTF: UITextField!
    @IBOutlet weak var languageTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    @IBOutlet weak var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Book"
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action: nil)
         navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Add",style:.plain, target: self, action: #selector(addBook))
        
//        text!.layer.borderWidth = 0.5
//        text!.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleTF.text = ""
        isbnTF.text = ""
        authorTF.text = ""
        publisherTF.text = ""
        categoryTF.text = ""
        descriptionTF.text = ""
        illustratorTF.text = ""
        pagesTF.text = ""
        coverArtistTF.text = ""
        languageTF.text = ""
        countryTF.text = ""
        
    }
    
    @objc func addBook(){
        //let book = Book(owner: user.record.share!, isbn: isbnTF.text!, title: titleTF.text!, description: descriptionTF.text!, author: authorTF.text!, illustrator: "", coverArtist: "", country: "", language: "", category: categoryTF.text!, publisher: publisherTF.text!, publicationDate: Date(), pages: 0, countryCode: "US")
        
        //Model.shared.addBook(book: book)
        
        
        Book.add(book: Book(owner: CKRecord.Reference(recordID: Model.shared.LoggedInUser.record.recordID, action: .none), isbn: isbnTF.text!, title: titleTF.text!, description: descriptionTF.text!, author: authorTF.text!, illustrator: illustratorTF.text!, coverArtist: coverArtistTF.text!, country: countryTF.text!, language: languageTF.text!, category: categoryTF.text!, publisher: publisherTF.text!, publicationDate: Date(), pages: Int(pagesTF.text!)!))
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(addedBook), name: NSNotification.Name(rawValue:"Added a New Book"), object: nil)
        
        // self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addedBook(){
        let ac = UIAlertController(title: "Book Added", message: "Successfully Added a Book", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style:.default, handler: nil)
        ac.addAction(action)
        self.present(ac,animated: true)
        
        tabBarController?.selectedIndex = 0
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
