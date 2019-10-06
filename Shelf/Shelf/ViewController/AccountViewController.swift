//
//  FirstViewController.swift
//  Shelf
//
//  Created by Student on 9/30/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Account"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style:.done, target:nil, action: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

