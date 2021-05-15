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
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        dismiss(animated: true)
        
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("couldn't load image")
        }
        
        scene.image = image
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        
        detectScene(image: ciImage)
    }
}

extension ViewController {
    func detectScene(image: CIImage) {
        answer.text = "detecting..."
        
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("can't load Places ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results,
                  let topResult = results.first as? VNClassificationObservation else {
                fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            let article = (["a", "e", "i", "o", "u"].contains(topResult.identifier.first!)) ? "an" : "a"
            
            DispatchQueue.main.async { [weak self] in
                self?.answer.text = "\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)"
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}

private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
