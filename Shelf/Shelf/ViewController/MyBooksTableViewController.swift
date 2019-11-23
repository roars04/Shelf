//
//  MyBooksTableViewController.swift
//  Shelf
//
//  Created by Student on 11/11/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class MyBooksTableViewController: UITableViewController {
    
    var filteredTableData:[Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Books"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Back",style:.plain, target: self, action: #selector(Back))
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("AllBooksOfAUser Fetched"), object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func reloadData(){
        DispatchQueue.main.async {
            self.filteredTableData = Array(Model.shared.booksOfAUser.values)
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Model.shared.getAllBooksOfUser(user: Model.shared.LoggedInUser!)
    }
    
    @objc func Back(){
        
//        let navCon = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//
//        self.present(navCon, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredTableData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myBookTVC", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = filteredTableData[indexPath.row].title
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
        let bookToBeDeleted = filteredTableData[indexPath.row]
        filteredTableData.remove(at: indexPath.row)
        Model.shared.deleteBook(book: bookToBeDeleted)
        //tableView.reloadData()
        tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    
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
