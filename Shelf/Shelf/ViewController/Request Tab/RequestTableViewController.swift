//
//  TableViewController.swift
//  Shelf
//
//  Created by Student on 10/4/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var index = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChange(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            tableView.reloadData()
            index = 0
            break
        case 1:
            tableView.reloadData()
            index = 1
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        navigationItem.title = "Request"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    @objc func add() {
        let AddNewRequestVCNavCon = storyboard?.instantiateViewController(withIdentifier: "AddNewRequestVCNavCon") as! UINavigationController
        self.present(AddNewRequestVCNavCon, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requests", for: indexPath)
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "recieved", for: indexPath)
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            let request = Model.shared.myRequests[indexPath.row]
            cell.textLabel?.text = request.bookTitle
            cell.detailTextLabel?.text = "\(request.location), \(request.city), \(request.state)"
            return cell
        case 1:
            let request = Model.shared.requestsRecieved[indexPath.row]
            cell2.textLabel?.text = request.bookTitle
            cell2.detailTextLabel?.text = "\(request.location), \(request.city), \(request.state)"
            return cell2
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            num = Model.shared.numMyRequests()
            break
        case 1:
            num = Model.shared.numRequestsRecieved()
            break
        default:
            break
        }
        return num
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
