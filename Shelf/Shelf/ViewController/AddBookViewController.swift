//
//  AddBookViewController.swift
//  Shelf
//
//  Created by student on 10/5/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CloudKit

class AddBookViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var isbnTF: UITextField!
    @IBOutlet weak var authorTF: UITextField!
    @IBOutlet weak var publisherTF: UITextField!
    @IBOutlet weak var categoryPV: UIPickerView!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var illustratorTF: UITextField!
    @IBOutlet weak var pagesTF: UITextField!
    @IBOutlet weak var coverArtistTF: UITextField!
    @IBOutlet weak var languageTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    var selectedCategory:String = Model.shared.categories[0]
    
    @IBOutlet weak var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Book"
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action: nil)
         navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Add",style:.plain, target: self, action: #selector(addBook))
        
//        text!.layer.borderWidth = 0.5
//        text!.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
        categoryPV.delegate = self
        categoryPV.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(addedBook), name: NSNotification.Name(rawValue:"Added a New Book"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addedBook), name: NSNotification.Name(rawValue:"Error with New Book"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        titleTF.text = ""
        isbnTF.text = ""
        authorTF.text = ""
        publisherTF.text = ""
        descriptionTF.text = ""
        illustratorTF.text = ""
        pagesTF.text = "0"
        coverArtistTF.text = ""
        languageTF.text = ""
        countryTF.text = ""
        
    }
    
    @objc func addBook(){
        //let book = Book(owner: user.record.share!, isbn: isbnTF.text!, title: titleTF.text!, description: descriptionTF.text!, author: authorTF.text!, illustrator: "", coverArtist: "", country: "", language: "", category: categoryTF.text!, publisher: publisherTF.text!, publicationDate: Date(), pages: 0, countryCode: "US")
        
        //Model.shared.addBook(book: book)
        guard let pages = Int(pagesTF.text!) else {
            let ac = UIAlertController(title: "Pages is not numeric", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true, completion: nil)
            return
        }
        guard let isbn = isbnTF.text else {
            let ac = UIAlertController(title: "Pages is not numeric", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true, completion: nil)
            return
        }
        
         Book.add(book: Book(owner: CKRecord.Reference(recordID: Model.shared.LoggedInUser.record.recordID, action: .none), isbn: isbn, title: titleTF.text!, description: descriptionTF.text!, author: authorTF.text!, illustrator: illustratorTF.text!, coverArtist: coverArtistTF.text!, country: countryTF.text!, language: languageTF.text!, category: self.selectedCategory, publisher: publisherTF.text!, publicationDate: Date(), pages: pages))
        
        // self.dismiss(animated: true, completion: nil)
 
    }
    
    @objc func addedBook(){
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Book Added", message: "Successfully Added a Book", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style:.default, handler: nil)
            ac.addAction(action)
            self.present(ac,animated: true)
        }
    }
    
    @objc func errorAddingBook(){
        let ac = UIAlertController(title: "Book could not be Added", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Model.shared.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Model.shared.categories[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCategory = Model.shared.categories[row]
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
