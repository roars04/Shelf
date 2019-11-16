//
//  FirstViewController.swift
//  Shelf
//
//  Created by Student on 9/30/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var PhoneLB: UILabel!
    @IBOutlet weak var EmailLB: UILabel!
    @IBOutlet weak var LocationLB: UILabel!
    @IBOutlet weak var NameLB: UILabel!    
    @IBAction func MyBooks(_ sender: Any) {
        
        let navCon = storyboard?.instantiateViewController(withIdentifier: "MyBooksTVC") as! MyBooksTableViewController
        self.navigationController?.pushViewController(navCon, animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Account"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Sign Out",style:.plain, target: self, action: #selector(Login))
        
        // Do any additional setup after loading the view, typically from a nib.
        let LoggedInUser = Model.shared.LoggedInUser!
        NameLB.text = "\(LoggedInUser.firstName + " " + LoggedInUser.lastName)"
        PhoneLB.text = LoggedInUser.phone
        EmailLB.text = LoggedInUser.email
        LocationLB.text = "\(LoggedInUser.city + ", " + LoggedInUser.state)"
    }
    
    @objc func Login(){
        
        let navCon = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
        
        self.present(navCon, animated: true, completion: nil)
    }
    
    
}

