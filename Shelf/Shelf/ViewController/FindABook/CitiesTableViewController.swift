//
//  PlacesTableViewController.swift
//  Shelf
//
//  Created by Student on 10/2/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBarCities: UISearchBar!
    
    var book:Book? = nil
    
    var city:[String] = []
    
    var filteredTableData:[String] = []
    
    func toUniqueCityArray(_ user:[User]) -> [String] {
        var result = Set<String>()
        for elem in user {
            if !result.contains(elem.city) {
                result.insert(elem.city)
            }
        }
        return Array(result)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        searchBarCities.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("AllOwnerOfABook Fetched"), object: nil)
    }
    
    @objc func reloadData(){
        DispatchQueue.main.async {
            self.city = self.toUniqueCityArray(Model.shared.ownerOfABook)
            self.filteredTableData = self.toUniqueCityArray(Model.shared.ownerOfABook)
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Book.getAllOwnerOfABook(isbn: book!.isbn)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredTableData = city.filter({ (city) -> Bool in
                city.lowercased().hasPrefix(searchText.lowercased())
            })
        } else {
            filteredTableData = city
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = filteredTableData[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ownersView = storyboard?.instantiateViewController(withIdentifier: "OwnersView") as! OwnersTableViewController
        ownersView.city = filteredTableData[indexPath.row]
        ownersView.isbn = self.book!.isbn
        navigationController?.pushViewController(ownersView, animated: false)
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
