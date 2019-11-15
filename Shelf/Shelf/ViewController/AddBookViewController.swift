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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Add",style:.plain, target: self, action: #selector(addBook))

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
 
        guard let pages = Int(pagesTF.text!) else {
            let ac = UIAlertController(title: "Pages is not numeric", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true, completion: nil)
            return
        }
        if isbnTF.text! == "" {
            let ac = UIAlertController(title: "Pages is not numeric", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true, completion: nil)
            return
        }
        
        Book.add(book: Book(owner: CKRecord.Reference(recordID: Model.shared.LoggedInUser.record.recordID, action: .none), isbn: isbnTF.text!, title: titleTF.text!, description: descriptionTF.text!, author: authorTF.text!, illustrator: illustratorTF.text!, coverArtist: coverArtistTF.text!, country: countryTF.text!, language: languageTF.text!, category: self.selectedCategory, publisher: publisherTF.text!, publicationDate: Date(), pages: pages))
    }
    
    @objc func addedBook(){
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Book Added", message: "Successfully Added a Book", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style:.default, handler: nil)
            ac.addAction(action)
            
            self.present(ac,animated: true)
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    @objc func errorAddingBook(){
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Book could not be Added", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(okAction)
            
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Model.shared.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Model.shared.categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
