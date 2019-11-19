//
//  RequestRecievedInfoViewController.swift
//  Shelf
//
//  Created by Student on 11/19/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class RequestRecievedInfoViewController: UIViewController {
    
    @IBOutlet weak var UsersNameLBL: UILabel!
    @IBOutlet weak var PhoneNumLBL: UILabel!
    @IBOutlet weak var EmailLBL: UILabel!
    @IBOutlet weak var LocationLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let LoggedInUser = Model.shared.LoggedInUser!
        UsersNameLBL.text = "\(LoggedInUser.firstName), \(LoggedInUser.lastName)"
        PhoneNumLBL.text = LoggedInUser.phone
        EmailLBL.text = LoggedInUser.email
        LocationLBL.text = "\(LoggedInUser.city), \(LoggedInUser.state)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationItem.title = "Request Recieved From:"
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"back", style:.plain, target: self, action: #selector(back))
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
}
