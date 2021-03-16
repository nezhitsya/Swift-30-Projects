//
//  ProductTableViewController.swift
//  ShoeShop
//
//  Created by 이다영 on 2021/03/15.
//

import UIKit

class ProductTableViewController: UITableViewController {
    
    private var products: [Product]?
    private var identifier = "productCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        products = [
            Product(name: "Vans Oldschool green", image: "shoe1", fullscreenImage: "shoe1"),
            Product(name: "Vans Oldschool", image: "shoe2", fullscreenImage: "shoe2"),
            Product(name: "Vans Oldschool white", image: "shoe3", fullscreenImage: "shoe3"),
            Product(name: "Vans Oldschool black", image: "shoe4", fullscreenImage: "shoe4"),
            Product(name: "Vans Checkerboard", image: "shoe5", fullscreenImage: "shoe5"),
            Product(name: "Vans Slip-On", image: "shoe6", fullscreenImage: "shoe6")
        ]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        guard let products = products else {return cell}
        
        cell.productImage.layer.cornerRadius = 10
        cell.configure(productImage: products[indexPath.row].image, productName: products[indexPath.row].name)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showProduct" {
//          if let cell = sender as? UITableViewCell,
//            let indexPath = tableView.indexPath(for: cell),
//            let productVC = segue.destination as? ProductViewController {
//            productVC.product = products?[indexPath.row]
//          }
//        }
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    if let vc = segue.destination as? ProductViewController {
                        vc.product = products?[indexPath.row]
                    }
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
