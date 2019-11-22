//
//  OwnersTableViewController.swift
//  Shelf
//
//  Created by Student on 10/2/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CloudKit

class OwnersTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarOwner: UISearchBar!
    
    var isbn:String = ""
    
    var city:String = ""
    
    var user:[User] = []
       
    var filteredTableData:[User] = []
    
    func userOfACity(_ user:[User]) -> [User] {
        var result:[User] = []
        for elem in user {
            if elem.city == city {
                result.append(elem)
            }
        }
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        searchBarOwner.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(addedRequest), name: NSNotification.Name("Added a New Request"), object: nil)
    }
    @objc func addedRequest(){
        let ac = UIAlertController(title: "Added a New Request", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {alert in
            self.navigationController?.popToRootViewController(animated: false)
        })
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.user = self.userOfACity(Model.shared.ownerOfABook)
            self.filteredTableData = self.userOfACity(Model.shared.ownerOfABook)
            self.filteredTableData.sort { (firstUser, secondUser) -> Bool in
                firstUser.firstName < secondUser.firstName
            }
            self.tableView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredTableData = user.filter({ (user) -> Bool in
                (user.firstName.lowercased() + " " + user.lastName.lowercased()).hasPrefix(searchText.lowercased())
            })
        } else {
            filteredTableData = user
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredTableData.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "owner", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = filteredTableData[indexPath.row].firstName + " " + filteredTableData[indexPath.row].lastName

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
        title: "Send a Request!") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            var decidedBook:Book? = nil
            for book in Model.shared.books {
                if book.owner.recordID == self.filteredTableData[indexPath.row].record.recordID && book.isbn == self.isbn{
                    decidedBook = book
                }
            }
            let request = Request(owner: CKRecord.Reference(recordID: Model.shared.LoggedInUser.record.recordID, action: .none), requestForBook: CKRecord.Reference(recordID: decidedBook!.record.recordID, action: .none), bookTitle: decidedBook!.title, isbn: decidedBook!.isbn ,location: Model.shared.LoggedInUser.street , city: Model.shared.LoggedInUser.city, state: Model.shared.LoggedInUser.state)
            Model.shared.addARequest(request: request)
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [action])
        return swipeConfig
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var decidedBook:Book? = nil
        for book in Model.shared.books {
            if book.owner.recordID == self.filteredTableData[indexPath.row].record.recordID && book.isbn == self.isbn{
                decidedBook = book
            }
        }
        let request = Request(owner: CKRecord.Reference(recordID: Model.shared.LoggedInUser.record.recordID, action: .none), requestForBook: CKRecord.Reference(recordID: decidedBook!.record.recordID, action: .none), bookTitle: decidedBook!.title, isbn: decidedBook!.isbn ,location: Model.shared.LoggedInUser.street , city: Model.shared.LoggedInUser.city, state: Model.shared.LoggedInUser.state)
        Model.shared.addARequest(request: request)
    }

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
