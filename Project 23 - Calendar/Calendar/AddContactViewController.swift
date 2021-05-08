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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthPicker.delegate = self
        nameText.delegate = self
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
    
}

extension AddContactViewController: UIPickerViewDelegate {
    
}

extension AddContactViewController: UITextFieldDelegate {
    
}
