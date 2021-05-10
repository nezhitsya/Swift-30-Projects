//
//  AddContactViewController.swift
//  Calendar
//
//  Created by 이다영 on 2021/05/08.
//

import UIKit
import Contacts
import ContactsUI

protocol AddContactViewControllerDelegate {
    func didFetchContacts(_ contacts: [CNContact])
}

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var monthPicker: UIPickerView!
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentlySelectedMonthIndex = 1
    var delegate: AddContactViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthPicker.delegate = self
        nameText.delegate = self
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(AddContactViewController.performSaveItemTap))
        navigationItem.rightBarButtonItem = saveBarButtonItem
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

extension AddContactViewController: CNContactPickerDelegate {
    @IBAction func showContacts(_ sender: AnyObject) {
        let contactPickerViewController = CNContactPickerViewController()
        
        contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "Birthday != nil")
        contactPickerViewController.delegate = self
        contactPickerViewController.displayedPropertyKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey]
        
        present(contactPickerViewController, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        delegate.didFetchContacts([contact])
        navigationController?.popViewController(animated: true)
    }
}

extension AddContactViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return months[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentlySelectedMonthIndex = row + 1
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        AppDelegate.appDelegate.requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                let predicate = CNContact.predicateForContacts(matchingName: self.nameText.text!)
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName), CNContactEmailAddressesKey, CNContactBirthdayKey] as [Any]
                let contactsStore = AppDelegate.appDelegate.contactStore
                var contacts = [CNContact]()
                var warningMessage: String!
                
                do {
                    contacts = try contactsStore.unifiedContacts(matching: predicate, keysToFetch: keys as! [CNKeyDescriptor])
                    
                    if contacts.count == 0 {
                        warningMessage = "No contacts were found matching the given name."
                    }
                } catch {
                    warningMessage = "Unable to fetch contacts."
                }
                
                if let warningMessage = warningMessage {
                    DispatchQueue.main.async {
                        Helper.show(message: warningMessage)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate.didFetchContacts(contacts)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        return true
    }
    
    @objc func performSaveItemTap() {
        AppDelegate.appDelegate.requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                var contacts = [CNContact]()
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName), CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey] as [Any]
                
                do {
                    let contactStore = AppDelegate.appDelegate.contactStore
                    
                    try contactStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])) { [weak self] (contact, pointer) -> Void in
                        
                        if contact.birthday != nil && contact.birthday!.month == self?.currentlySelectedMonthIndex {
                            contacts.append(contact)
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate.didFetchContacts(contacts)
                        self.navigationController?.popViewController(animated: true)
                    }
                } catch let error as NSError {
                    print(error.description, separator: "", terminator: "\n")
                }
            }
        }
    }
}
