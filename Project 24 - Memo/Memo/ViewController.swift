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
        
        cell.textLabel!.text = memo.value(forKey: "name") as? String
        
        return cell
    }
}

