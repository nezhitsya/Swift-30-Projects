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
            
        }
    }
    
    @IBAction func didTapTanimate(_ sender: AnyObject) {
        switch bartitle {
        case "2-Color":
            changeColor(UIColor.gray)
        
        case "Simple 2D Rotation":
            rotateView(Double.pi)
            
        case "Multicolor":
            multiColor(UIColor.black, UIColor.gray)
        }
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
