//
//  ViewController.swift
//  Memo
//
//  Created by 이다영 on 2021/05/11.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    var memos: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.fetchCoreData(managedContext)
    }
    
    func fetchCoreData(_ managedContext: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            memos = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let memo = memos[indexPath.row]
        
        cell.textLabel!.text = memo.value(forKey: "content") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(memos[indexPath.row] as NSManagedObject)
            
            do {
                try managedContext.save()
                memos.remove(at: indexPath.row)
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            return
        }
    }
    
    func saveMemo(_ content: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Memo", in: managedContext)
        let memo = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        memo.setValue(content, forKey: "content")
        
        do {
            try managedContext.save()
            memos.append(memo)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addMemo(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Memo", message: "Add a new memo", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(action: UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            
            self.saveMemo(textField!.text!)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(action: UIAlertAction) -> Void in })
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

