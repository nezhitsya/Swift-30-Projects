//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/10/07.
//

import UIKit
import MapKit

class SearchCityViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var searchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()
    private var searchResults: [MKLocalSearchCompletion] = [MKLocalSearchCompletion]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViewController()
        registerNib()
    }
    
    private func setupViewController() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchCompleter.delegate = self
    }
    
    private func registerNib() {
        tableView.register(SearchListTableViewCell.self)
    }
    
    private func updateSearchResults(selected: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: selected)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            if error != nil {
                print(APIError.requestFailed)
            }
            let coordinate = response?.mapItems.first?.placemark.coordinate
            
            NotificationCenter.default.post(name: .selectCity,
                                            object: coordinate)
            self.dismiss(animated: true, completion: nil)
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

// MARK: TableView Delegate and DataSource
extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.config(data: searchResults[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSearchResults(selected: searchResults[indexPath.row])
    }
    
}

// MARK: SearchBar Delegate
extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text,
              searchText.count > 0 else {
                  searchResults.removeAll()
                  return
              }
        searchCompleter.queryFragment = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
              searchText.count > 0 else {
                  return
              }
        searchBar.resignFirstResponder()
    }
    
}

// MARK: ScrollView Delegate
extension SearchCityViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}

// MARK: MKLocalSearchCompleterDelegate
extension SearchCityViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
    
}

