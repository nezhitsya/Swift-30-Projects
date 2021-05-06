//
//  ViewController.swift
//  Calendar
//
//  Created by 이다영 on 2021/05/06.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController {
    
    @IBOutlet weak var contactsTable: UITableView!
    
    var contacts = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }

    func configureTableView() {
        contactsTable.delegate = self
        contactsTable.dataSource = self
        contactsTable.register(UINib(nibName: "ContactCalendarCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CalendarTableViewCell
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            contactsTable.reloadData()
        }
    }
}
