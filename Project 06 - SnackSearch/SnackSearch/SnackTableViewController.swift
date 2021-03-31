//
//  SnackTableViewController.swift
//  SnackSearch
//
//  Created by 이다영 on 2021/03/30.
//

import UIKit

class SnackTableViewController: UITableViewController {

    var snack = [Snack]()
    var filteredSnack = [Snack]()
    var detailViewController: DetailViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        snack = [
            Snack(category: "Cookies", name: "Chocolate chip cookie"),
            Snack(category: "Cookies", name: "Fortune cookie"),
            Snack(category: "Cookies", name: "Cracker"),
            Snack(category: "Cookies", name: "Biscuit"),
            Snack(category: "Cookies", name: "Macaron"),
            Snack(category: "Cookies", name: "Oreo"),
            Snack(category: "Cakes", name: "Madeleine"),
            Snack(category: "Cakes", name: "Brownie"),
            Snack(category: "Cakes", name: "Baumkuchen"),
            Snack(category: "Cakes", name: "Cupcake"),
            Snack(category: "Cakes", name: "Financier"),
            Snack(category: "Cakes", name: "Pancake"),
            Snack(category: "Pastries", name: "Croissant"),
            Snack(category: "Pastries", name: "Churros"),
            Snack(category: "Pastries", name: "Éclair"),
            Snack(category: "Pastries", name: "Scones"),
            Snack(category: "Pastries", name: "Canelé")
        ]
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Snack"
        
        setupSearchController()
        
        if let splitViewController = splitViewController {
              let controllers = splitViewController.viewControllers
              detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["All", "Cookies", "Cakes", "Pastries"]
        searchController.searchBar.delegate = self
        
        if #available(iOS 11, *) {
            self.navigationItem.searchController = searchController
            self.navigationItem.searchController?.isActive = true
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredSnack = snack.filter { snacks in
            if !(snacks.category == scope) && scope != "All" {
                return false
            }
            return snacks.name.lowercased().contains(searchText.lowercased()) || searchText == ""
        }
        
        tableView.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return filteredSnack.count
        }
        return snack.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let snacks: Snack
        
        if searchController.isActive {
            snacks = filteredSnack[(indexPath as NSIndexPath).row]
        } else {
            snacks = snack[(indexPath as NSIndexPath).row]
        }
        
        cell.textLabel!.text = snacks.name
        cell.detailTextLabel!.text = snacks.category

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let snacks: Snack
                
                if searchController.isActive {
                    snacks = filteredSnack[(indexPath as NSIndexPath).row]
                } else {
                    snacks = snack[(indexPath as NSIndexPath).row]
                }
                
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                let controller = segue.destination as! DetailViewController
                
                controller.detailSnack = snacks
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
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

extension SnackTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension SnackTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
