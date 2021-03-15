//
//  ContactViewController.swift
//  ShoeShop
//
//  Created by 이다영 on 2021/03/15.
//

import UIKit

class ContactViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
          scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
        } else {
          scrollView.frame = CGRect(x: 0, y: topLayoutGuide.length, width: view.frame.width, height: view.frame.height - topLayoutGuide.length - bottomLayoutGuide.length)
        }
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
    }
}
