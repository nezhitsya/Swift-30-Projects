//
//  DetailViewController.swift
//  Dictionary
//
//  Created by 이다영 on 2021/03/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
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
//        self.title = animal.name
//        name?.text = animal.name
//        info?.text = animal.detailInfo
//        animalImage?.image = LibraryAPI.sharedInstance.downloadImg(animal.animImgUrl)
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
    func aninalSelected(_ newAnimal: Animal) {
        animal = newAnimal
    }
}
