//
//  TableViewCell.swift
//  ProfileOptions
//
//  Created by 이다영 on 2021/03/19.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "tableCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        detailTextLabel?.textColor = UIColor.gray
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
