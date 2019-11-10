//
//  CategoriesTableViewController.swift
//  Shelf
//
//  Created by Student on 10/2/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var filteredTableData = Model.shared.categories
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Reload the table
        tableView.reloadData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController!.searchResultsUpdater = self
        resultSearchController!.obscuresBackgroundDuringPresentation = false
        resultSearchController!.searchBar.sizeToFit()

        tableView.tableHeaderView = resultSearchController!.searchBar
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
            let array = (filteredTableData as NSArray).filtered(using: searchPredicate)
            filteredTableData = array as! [String]
        } else {
            filteredTableData = Model.shared.categories
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        // #warning Incomplete implementation, return the number of rows
        return filteredTableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = filteredTableData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.tableHeaderView = nil
        let booksView = storyboard?.instantiateViewController(withIdentifier: "BooksView")
        navigationController?.pushViewController(booksView!, animated: false)
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
