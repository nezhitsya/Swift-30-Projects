//
//  ViewController.swift
//  SlideMenu
//
//  Created by 이다영 on 2021/04/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    enum vcName: String {
        case first = "FirstViewController"
        case second = "SecondViewController"
        case third = "ThirdViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: view.frame.width * 4, height: view.frame.height)
        scrollView.contentOffset.x = view.frame.width
        
        let firstVC = UIViewController(nibName: vcName.first.rawValue, bundle: nil)
        let secondVC = UIViewController(nibName: vcName.second.rawValue, bundle: nil)
        let thirdVC = UIViewController(nibName: vcName.third.rawValue, bundle: nil)
        add(childViewController: firstVC, toParentViewController: self)
        add(childViewController: secondVC, toParentViewController: self)
        add(childViewController: thirdVC, toParentViewController: self)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func add(childViewController: UIViewController, toParentViewController parentViewController: UIViewController) {
        addChild(childViewController)
        scrollView.addSubview(childViewController.view)
        childViewController.didMove(toParent: parentViewController)
    }
}

