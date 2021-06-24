//
//  MainTableViewController.swift
//  Dictionary
//
//  Created by 이다영 on 2021/03/31.
//

import UIKit
import RxSwift
import RxCocoa

protocol AnimalSelectionDelegate: AnyObject {
    func aninalSelected(_ newAnimal: Animal)
}

class MainTableViewController: UITableViewController {
    
    var animals = LibraryAPI.sharedInstance.getAnimals()
    var filteredAnimals = [Animal]()
    weak var delegate: AnimalSelectionDelegate?
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        filteredAnimals = animals
    }
    
    private func setupUI() {
        self.title = "Dictionary"
        
        definesPresentationContext = true
        
        self.filteredAnimals = self.animals
        self.tableView.reloadData()
        
//        searchBar
//            .rx.text
//            .throttle(0.5, scheduler: MainScheduler.instance)
//            .subscribe(
//                onNext: { [unowned self] query in
//                    if query?.characters.count == 0 {
//                        self.filteredAnimals = self.animals
//                    } else {
//                        self.filteredAnimals = self.animals.filter {
//                            $0.name.hasPrefix(query!)
//                        }
//                    }
//                    self.tableView.reloadData()
//                })
//            .addDisposableTo(disposeBag)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredAnimals.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animal = self.filteredAnimals[(indexPath as NSIndexPath).row]
        
        delegate?.aninalSelected(animal)
        print(delegate?.aninalSelected(animal) as Any)
        
        if let detailViewController = self.delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MainTableViewCell
        let animal = filteredAnimals[(indexPath as NSIndexPath).row]
        
        cell.awakeFromNib(animal.stringType, name: animal.name, animalImageUrl: animal.animImgUrl)
        
        return cell
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
