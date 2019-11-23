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
        navigationItem.title = "Request Recieved From:"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Back", style:.plain, target: self, action: #selector(back))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        UsersNameLBL.text = "\(Model.shared.userOfRequest!.firstName) \(Model.shared.userOfRequest!.lastName)"
        PhoneNumLBL.text = "\(Model.shared.userOfRequest!.phone)"
        EmailLBL.text = "\(Model.shared.userOfRequest!.email)"
        LocationLBL.text = "\(Model.shared.userOfRequest!.city), \(Model.shared.userOfRequest!.state)"
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
}
