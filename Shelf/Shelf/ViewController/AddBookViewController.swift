//
//  AddBookViewController.swift
//  Shelf
//
//  Created by student on 10/5/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit


class AddBookViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Book"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action: nil)
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style:.done, target:nil, action: nil)
        
        text!.layer.borderWidth = 0.5
        text!.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
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
