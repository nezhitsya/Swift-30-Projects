//
//  DataManager.swift
//  ToDoList
//
//  Created by 이다영 on 2021/03/24.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    private init() {
        
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var todoList = [ToDoList]()
    
    // read Data
    func fetchMemo() {
        let request: NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            todoList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func addNewMemo(_ title: String?, _ descript: String?, _ date: Double?, _ isComplete: Bool) {
        let newTodo = ToDoList(context: mainContext)
        newTodo.title = title
        newTodo.descript = descript
        newTodo.date = date!
        newTodo.isComplete = false
        
        todoList.insert(newTodo, at: 0)
        
        saveContext()
    }
    
    func deleteMemo(_ todo: ToDoList?) {
        if let todo = todo {
            mainContext.delete(todo)
            saveContext()
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Memo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
