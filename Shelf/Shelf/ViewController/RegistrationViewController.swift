//
//  RegistrationViewController.swift
//  Shelf
//
//  Created by student on 11/11/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var FirstNameTF: UITextField!
    @IBOutlet weak var LastNameTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var StreetTF: UITextField!
    @IBOutlet weak var CityTF: UITextField!
    @IBOutlet weak var StateTF: UITextField!
    @IBOutlet weak var PostalTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
          navigationItem.title = "Registration"
          navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Save",style:.plain, target: self, action: #selector(SaveUser))

        // Do any additional setup after loading the view.
    }
    

    @objc func SaveUser(){
        
        
        
        let userdata = User(email: EmailTF.text!, password: PasswordTF.text!, lastName: LastNameTF.text!, firstName: FirstNameTF.text!, city: CityTF.text!, street: StreetTF.text!
            , state: StateTF.text!, postal: PostalTF.text!)
        
        Model.shared.add(user: userdata)
        
       self.dismiss(animated: true, completion: nil)
        
        
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
