//
//  ViewController.swift
//  PhotoList
//
//  Created by 이다영 on 2021/04/16.
//

import UIKit
import CoreImage

let imageURL = URL(string: "https://downgit.github.io/#/home?url=https://github.com/nezhitsya/Swift-30-Projects/blob/master/Project%2017%20-%20PhotoList/Photos.plist")

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photos"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        return cell
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

