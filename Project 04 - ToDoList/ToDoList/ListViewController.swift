//
//  ViewController.swift
//  ToDoList
//
//  Created by 이다영 on 2021/03/20.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy hh:mm"
        return f
    }()

    @IBOutlet weak var todoListTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataManager.shared.fetchTodo()
        todoListTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        
        todoListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = DataManager.shared.todoList[indexPath.row]
        let todoDate = Date(timeIntervalSince1970: target.date)
        
        cell.textLabel?.text = target.title
        cell.detailTextLabel?.text = formatter.string(from: todoDate)
        cell.detailTextLabel?.textColor = UIColor(named: "LabelColor")

        if target.isComplete {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let target = DataManager.shared.todoList[indexPath.row]
            DataManager.shared.deleteTodo(target)
            DataManager.shared.todoList.remove(at: indexPath.row)
            
            todoListTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
