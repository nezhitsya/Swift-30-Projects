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
        refreshUI()
        super.viewDidLoad()
    }
    
    func refreshUI() {
        self.title = "Animal"
//        self.title = animal.name
        name?.text = "Snake"
        info?.text = "뱀은 뱀아목에 속하는 파충류의 총칭으로 다리가 퇴화한 것이 특징이다. 거의 대부분 전체 길이가 1~2m이지만 큰 것은 10m, 작은 것은 10cm인 것도 있다. 현재 456속의 약 2,900종으로 남극과 아일랜드섬을 제외한 세계의 각 대륙에 널리 분포하며, 일부는 북극권 부근까지 서식하고 있다."
//        animalImage?.image = LibraryAPI.sharedInstance.downloadImg(animal.animImgUrl)
        animalImage?.image = UIImage(named: "default")
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
