//
//  ViewController.swift
//  SlideMenu
//
//  Created by 이다영 on 2021/04/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: view.frame.width * 4, height: view.frame.height)
        scrollView.contentOffset.x = view.frame.width
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

