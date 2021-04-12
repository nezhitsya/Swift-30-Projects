//
//  MenuViewController.swift
//  ActiveMenu
//
//  Created by 이다영 on 2021/04/11.
//

import UIKit

class MenuViewController: UIViewController {
    
    let transitionManager = TransitionManager()
    
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var search: UIImageView!
    @IBOutlet weak var text: UIImageView!
    @IBOutlet weak var alarm: UIImageView!
    @IBOutlet weak var call: UIImageView!
    @IBOutlet weak var setting: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transitioningDelegate = self.transitionManager
    }
    
    @IBAction func cancel(_ sender: Any) {
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
