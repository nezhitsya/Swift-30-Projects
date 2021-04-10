//
//  DetailViewController.swift
//  Animation
//
//  Created by 이다영 on 2021/04/10.
//

import UIKit

class DetailViewController: UIViewController {
    
    var barTitle = ""
    var animateView: UIView!
    private let duration = 2.0
    private let delay = 0.2
    private let scale = 1.2

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRect()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = barTitle
    }
    
    private func setupRect() {
        if barTitle == "BezierCurve Position" {
            animateView = drawCircleView()
        } else if barTitle == "View Fade In" {
            animateView = UIImageView(image: UIImage(named: "1"))
            animateView.frame = generalFrame
            animateView.center = generalCenter
        } else {
            animateView = drawRectView(UIColor.lightGray, frame: generalFrame, center: generalCenter)
        }
        view.addSubview(animateView)
    }
    
    private func changeColor(_ color: UIColor) {
        UIView.animate(withDuration: self.duration, animations: {
            self.animateView.backgroundColor = color
        }, completion: nil)
    }
    
    @IBAction func didTapTanimate(_ sender: AnyObject) {
        switch barTitle {
        case "2-Color":
            changeColor(UIColor.gray)

//        case "Simple 2D Rotation":
//            rotateView(Double.pi)
//
//        case "Multicolor":
//            multiColor(UIColor.black, UIColor.gray)
        
        default:
            let alert = makeAlert("Alert", message: "Error", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
