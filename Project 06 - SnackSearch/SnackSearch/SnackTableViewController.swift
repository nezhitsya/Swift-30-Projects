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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
