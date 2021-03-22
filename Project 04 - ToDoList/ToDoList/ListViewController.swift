//
//  ViewController.swift
//  ToDoList
//
//  Created by 이다영 on 2021/03/20.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var todoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        cell.textLabel?.text = list[indexPath.row].title
//        cell.detailTextLabel?.text = list[indexPath.row].content
//        if list[indexPath.row].isComplete {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }

        return cell
    }
}
