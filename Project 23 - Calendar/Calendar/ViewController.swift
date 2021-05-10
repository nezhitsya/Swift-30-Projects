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
    
    @IBAction func addContact(_ sender: AnyObject) {
        performSegue(withIdentifier: "AddContact", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "AddContact" {
                let addContactViewController = segue.destination as! AddContactViewController
                addContactViewController.delegate = self
            }
        }
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
                cell.date.text = birthday.asString
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
        AppDelegate.appDelegate.requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName), CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey] as [Any]
                
                do {
                    let contactRefetched = try AppDelegate.appDelegate.contactStore.unifiedContact(withIdentifier: contact.identifier, keysToFetch: keys as! [CNKeyDescriptor])
                    
                    self.contacts[indexPath.row] = contactRefetched
                    
                    DispatchQueue.main.async {
                        self.contactsTable.reloadRows(at: [indexPath], with: .automatic)
                    }
                } catch {
                    print("Unable to refetch the contact: \(contact)", separator: "", terminator: "\n")
                }
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contacts[indexPath.row]
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName), CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey] as [Any]
        
        if selectedContact.areKeysAvailable([CNContactViewController.descriptorForRequiredKeys()]) {
            let contactViewController = CNContactViewController(for: selectedContact)
            
            contactViewController.contactStore = AppDelegate.appDelegate.contactStore
            contactViewController.displayedPropertyKeys = keys
            navigationController?.pushViewController(contactViewController, animated: true)
        } else {
            AppDelegate.appDelegate.requestForAccess(completionHandler: { (accessGranted) -> Void in
                if accessGranted {
                    do {
                        let contactRefetched = try AppDelegate.appDelegate.contactStore.unifiedContact(withIdentifier: selectedContact.identifier, keysToFetch: [CNContactViewController.descriptorForRequiredKeys()])
                        
                        DispatchQueue.main.async {
                            let contactViewController = CNContactViewController(for: contactRefetched)
                            
                            contactViewController.contactStore = AppDelegate.appDelegate.contactStore
                            contactViewController.displayedPropertyKeys = keys
                            self.navigationController?.pushViewController(contactViewController, animated: true)
                        }
                    } catch {
                        print("Unable to refetch the selected contact.", separator: "", terminator: "\n")
                    }
                }
            })
        }
    }
}

extension ViewController: AddContactViewControllerDelegate {
    func didFetchContacts(_ contacts: [CNContact]) {
        for contact in contacts {
            self.contacts.append(contact)
        }
        contactsTable.reloadData()
    }
}
