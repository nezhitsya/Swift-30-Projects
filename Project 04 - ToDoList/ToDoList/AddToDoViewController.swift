//
//  AddToDoViewController.swift
//  ToDoList
//
//  Created by 이다영 on 2021/03/21.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var todoDescription: UITextView!
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var list = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoDescription.layer.borderWidth = 1
        todoDescription.layer.cornerRadius = 10
        todoDescription.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }

    @IBAction func save(_ sender: Any) {
        let title = todoTitle.text!
        let description = todoDescription.text ?? ""
        let date = todoDate.date
        
        let item: ToDo = ToDo(title: title, description: description, date: date.timeIntervalSince1970, isComplete: false)
        list.append(item)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
