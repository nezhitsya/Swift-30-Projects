//
//  ViewController.swift
//  SlideMenu
//
//  Created by 이다영 on 2021/04/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    enum vcName: String {
        case first = "FirstViewController"
        case second = "SecondViewController"
        case third = "ThirdViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = UIViewController(nibName: vcName.first.rawValue, bundle: nil)
        let secondVC = UIViewController(nibName: vcName.second.rawValue, bundle: nil)
        let thirdVC = UIViewController(nibName: vcName.third.rawValue, bundle: nil)
        add(childViewController: firstVC, toParentViewController: self)
        add(childViewController: secondVC, toParentViewController: self)
        add(childViewController: thirdVC, toParentViewController: self)
        
        changeX(ofView: self.imageView, xPosition: view.frame.width)
        scrollView.addSubview(self.imageView)
        
        changeX(ofView: firstVC.view, xPosition: view.frame.width * 1)
        changeX(ofView: secondVC.view, xPosition: view.frame.width * 2)
        changeX(ofView: thirdVC.view, xPosition: view.frame.width * 3)
        
        scrollView.contentSize = CGSize(width: view.frame.width * 4, height: view.frame.height)
        scrollView.contentOffset.x = view.frame.width
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func changeX(ofView view: UIView, xPosition: CGFloat) {
        var frame = view.frame
        
        frame.origin.x = xPosition
        view.frame = frame
    }
    
    private func add(childViewController: UIViewController, toParentViewController parentViewController: UIViewController) {
        addChild(childViewController)
        scrollView.addSubview(childViewController.view)
        childViewController.didMove(toParent: parentViewController)
    }
}

