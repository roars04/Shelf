//
//  BooksTableViewController.swift
//  Shelf
//
//  Created by Student on 10/2/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var searchBarBooks: UITableView!
    
    var category:String = "Action"
    
    var filteredTableData:[Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
                
        searchBarBooks.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("AllBooksOfACategory Fetched"), object: nil)

    }
    
    @objc func reloadData(){
        filteredTableData = Array(Model.shared.booksOfACategory.values)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Book.getAllBooksOfCategory(category: category)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredTableData = Array(Model.shared.booksOfACategory.values).filter({ (book) -> Bool in
                book.title.lowercased().hasPrefix(searchText.lowercased())
            })
        } else {
            filteredTableData = Array(Model.shared.booksOfACategory.values)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = filteredTableData[indexPath.row].title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let placesView = storyboard?.instantiateViewController(withIdentifier: "PlacesView") as! PlacesTableViewController
        placesView.book = filteredTableData[indexPath.row]
        navigationController?.pushViewController(placesView, animated: false)
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
