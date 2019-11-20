//
//  AddNewRequestViewController.swift
//  Shelf
//
//  Created by Student on 10/22/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CloudKit

class AddNewRequestViewController: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var isbnTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationItem.title = "Add New Request"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func add() {
        let bookTitle = titleTF.text!
        let isbn = isbnTF.text!
        let location = locationTF.text!
        let city = cityTF.text!
        let state = stateTF.text!
        if bookTitle == "" {
            let ac = UIAlertController(title: "No new Request without a Title", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true, completion: nil)
            return
        }
        if isbn == "" {
            let ac = UIAlertController(title: "No new Request without a ISBN", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true, completion: nil)
            return
        }
        let request = Request(owner: CKRecord.Reference(recordID: Model.shared.LoggedInUser.record.recordID, action: .none), bookTitle: bookTitle, isbn: isbn, location: location, city: city, state: state)
        Model.shared.myRequests.append(request)
        Request.add(request: request)
        self.dismiss(animated: true, completion: nil)
    }
    
}
