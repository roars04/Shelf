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
        let bookTitle = titleTF.text
        let location = locationTF.text
        let city = cityTF.text
        let state = stateTF.text
        let request = Request(owner: CKRecord.Reference(recordID: Model.shared.LoggedInUser.record.recordID, action: .none), bookTitle: bookTitle!, location: location!, city: city!, state: state!)
        Request.add(request: request)
        self.dismiss(animated: true, completion: nil)
    }
    
}
