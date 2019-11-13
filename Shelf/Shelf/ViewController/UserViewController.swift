//
//  UserViewController.swift
//  Shelf
//
//  Created by student on 10/22/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBAction func loginClicked(_ sender: Any) {
        
   Model.shared.Login(username: EmailTF.text!, Password: PasswordTF.text!)
        
  //      var user = Model.shared.LoggedInUser
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Register",style:.plain, target: self, action: #selector(RegisterUser))
        
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: nil, action: nil)
        
    navigationItem.title = "Shelf"
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToHome), name: NSNotification.Name("Login Sucess"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func RegisterUser(){
        
        let navCon = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! UINavigationController
        
        
        self.present(navCon, animated: true, completion: nil)
    }

    @objc func redirectToHome(){
        // navigationItem.backBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
        DispatchQueue.main.async {
              self.performSegue(withIdentifier: "login", sender: nil)
       
        }
    //
        
        
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
