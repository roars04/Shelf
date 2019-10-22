//
//  AddNewRequestViewController.swift
//  Shelf
//
//  Created by Student on 10/22/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class AddNewRequestViewController: UIViewController {

    
    
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
        
    }
    
}
