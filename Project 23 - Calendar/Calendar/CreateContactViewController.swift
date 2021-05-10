//
//  CreateContactViewController.swift
//  Calendar
//
//  Created by 이다영 on 2021/05/08.
//

import UIKit
import Contacts

class CreateContactViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameText.delegate = self
        emailText.delegate = self
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(CreateContactViewController.createContact))
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @objc func createContact() {
        let newContact = CNMutableContact()
        
        newContact.givenName = nameText.text!
        
        if let homeEmail = emailText.text {
            let homeEmail = CNLabeledValue(label: CNLabelHome, value: homeEmail as NSString)
            
            newContact.emailAddresses = [homeEmail]
        }
        
        let birthdayComponents = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: datePicker.date)
        newContact.birthday = birthdayComponents
        
        do {
            let saveRequest = CNSaveRequest()
            
            saveRequest.add(newContact, toContainerWithIdentifier: nil)
            
            try AppDelegate.appDelegate.contactStore.execute(saveRequest)
            
            navigationController?.popViewController(animated: true)
        } catch {
            Helper.show(message: "Unable to save the new contact.")
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

extension CreateContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
