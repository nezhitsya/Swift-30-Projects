//
//  NewsTableViewController.swift
//  Newspaper
//
//  Created by 이다영 on 2021/04/03.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let feedParser = RSSParser()
    private let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    private var rssItems: [(title: String, description: String, pubDate: String)]?
    private var cellStates: [CellState]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
            
            self?.rssItems = rssItems
            self?.cellStates = Array(repeating: .collapsed, count: rssItems.count)
            
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell

        if let item = rssItems?[indexPath.row] {
            (cell.title.text, cell.descript.text, cell.date.text) = (item.title, item.description, item.pubDate)
            
            if let cellState = cellStates?[indexPath.row] {
                cell.descript.numberOfLines = cellState == .expanded ? 0 : 4
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        
        tableView.beginUpdates()
        cell.descript.numberOfLines = cell.descript.numberOfLines == 4 ? 0 : 4
        cellStates?[indexPath.row] = cell.descript.numberOfLines == 4 ? .collapsed : .expanded
        tableView.endUpdates()
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
