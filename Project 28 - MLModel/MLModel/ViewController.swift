//
//  ViewController.swift
//  MLModel
//
//  Created by 이다영 on 2021/05/15.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var scene: UIImageView!
    @IBOutlet weak var answer: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "start") else {
            fatalError("There's no start image")
        }
        
        scene.image = image
    }
}

extension ViewController {
    
    @IBAction func pickImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
