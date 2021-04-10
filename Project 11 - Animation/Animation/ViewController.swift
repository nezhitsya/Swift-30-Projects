//
//  ViewController.swift
//  Animation
//
//  Created by 이다영 on 2021/04/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var masterTable: UITableView!
    
    private let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position", "Color and Frame Change", "View Fade In", "Pop"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        masterTable.delegate = self
        masterTable.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        masterTable.reloadData()
        
        let cells = masterTable.visibleCells
        let tableHeight = masterTable.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for cell in cells {
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AnimationDetail" {
            if let cell = sender as? UITableViewCell, let indexPath = masterTable.indexPath(for: cell) {
                if let vc = segue.destination.children.first as? DetailViewController {
                    vc.barTitle = items[(indexPath as NSIndexPath).row]
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50.0)
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Animations"
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.items[(indexPath as NSIndexPath).row]
        
        return cell
    }
}
