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
        let currentContact = contacts[indexPath.row]
        
        cell.fullName.text = CNContactFormatter.string(from: currentContact, style: .fullName)
        
        if !currentContact.isKeyAvailable(CNContactBirthdayKey) || !currentContact.isKeyAvailable(CNContactImageDataKey) || !currentContact.isKeyAvailable(CNContactEmailAddressesKey) {
            refetch(contact: currentContact, atIndexPath: indexPath)
        } else {
            if let birthday = currentContact.birthday {
                cell.date.text = DateFormatter().string(for: birthday)
            } else {
                cell.date.text = "Not available birthday date"
            }
            
            if let imageData = currentContact.imageData {
                cell.contactImage.image = UIImage(data: imageData)
            }
            
            var homeEmailAddress: String!
            
            for emailAddress in currentContact.emailAddresses {
                if emailAddress.label == CNLabelHome {
                    homeEmailAddress = emailAddress.value as String
                    break
                }
            }
            
            if let homeEmailAddress = homeEmailAddress {
                cell.email.text = homeEmailAddress
            } else {
                cell.email.text = "Not available email address"
            }
        }
        
        return cell
    }
    
    private func refetch(contact: CNContact, atIndexPath indexPath: IndexPath) {
        
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
