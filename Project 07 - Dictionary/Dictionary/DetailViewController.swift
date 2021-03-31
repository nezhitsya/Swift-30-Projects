//
//  DetailViewController.swift
//  Dictionary
//
//  Created by 이다영 on 2021/03/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var animal: Animal! {
        didSet(newAnimal) {
            self.refreshUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshUI()
    }
    
    func refreshUI() {
        
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

extension DetailViewController: AnimalSelectionDelegate {
    func animalSelected(_ newAnimal: Animal) {
        animal = newAnimal
    }
}
