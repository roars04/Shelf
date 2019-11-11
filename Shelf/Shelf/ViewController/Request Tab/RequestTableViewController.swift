//
//  TableViewController.swift
//  Shelf
//
//  Created by Student on 10/4/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class RequestTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChange(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "requests", for: indexPath)
                let request = Model.shared.myRequests[indexPath.row]
                cell.textLabel?.text = request.bookTitle
                cell.detailTextLabel?.text = request.location
                
                return cell
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return Model.shared.numMyRequests()
            }
        case 1:
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "requests", for: indexPath)
                let request = Model.shared.requestsRecieved[indexPath.row]
                cell.textLabel?.text = request.bookTitle
                cell.detailTextLabel?.text = request.location
                
                return cell
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return Model.shared.numRequestsRecieved()
            }
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Request"
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

/*    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Model.shared.numMyRequests()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requests", for: indexPath)
        let request = Model.shared.myRequests[indexPath.row]
        cell.textLabel?.text = request.bookTitle
        cell.detailTextLabel?.text = request.location

        return cell
    } */

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
