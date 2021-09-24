//
//  SearchViewController.swift
//  Netflix
//
//  Created by 이다영 on 2021/09/19.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    private var persistencyManager: PersistencyManager!
    var filteredMovies = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        persistencyManager = PersistencyManager()
        filteredMovies = persistencyManager.allMovies
        
        resultCollectionView.dataSource = self
        searchBar.delegate = self
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = persistencyManager.allMovies.filter { movie in
            return movie.key.lowercased().contains(searchText.lowercased()) || searchText == ""
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

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        var urls = [String]()
        
        for movie in filteredMovies {
            urls.append(movie.value)
        }
        
        let imageURL = URL(string: urls[(indexPath as NSIndexPath).item])
        if let imageData = try? Data(contentsOf: imageURL!) {
            cell.posterImage.image = UIImage(data: imageData)
        }
        
        return cell
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    private func dismisskeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("start")
        
        dismisskeyboard()
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        print("search \(searchTerm)")
        
        filterContentForSearchText(searchTerm)
        self.resultCollectionView.reloadData()
    }
}
