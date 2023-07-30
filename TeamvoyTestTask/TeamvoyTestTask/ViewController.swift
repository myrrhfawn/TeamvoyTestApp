//
//  ViewController.swift
//  TeamvoyTestTask
//
//  Created by Ростик on 29.07.2023.
//

import UIKit


class ViewController: UIViewController {
    // MARK: -IBOutlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    private var articles: [Article] = []
        
    var filteredData = [Article]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable(_ :)), name: Notification.Name("update"), object: nil)
        tableView?.allowsSelection = true
        self.searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ArticleCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleCell")
        APIManager.shared.getArticles { [weak self] articlesArray in
            DispatchQueue.main.async {
                guard let self else { return }
                self.articles = articlesArray
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func updateTable(_ notification: Notification){
        self.viewDidLoad()
    }
}

// MARK: -UITableViewDataSource


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        } else {
            return articles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
       
        if isSearching {
            cell.configure(with: filteredData[indexPath.row].title, description: filteredData[indexPath.row].description)
        } else {
            cell.configure(with: articles[indexPath.row].title, description: articles[indexPath.row].description)
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "detailSegue"){
            let indexPath = self.tableView.indexPathForSelectedRow!
            let tableViewArticle = segue.destination as? ArticleViewController
            let selectedArticle = articles[indexPath.row]
            tableViewArticle!.selectedArticle = selectedArticle
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData.removeAll()
        if searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            for item in articles {
                let text = searchText.lowercased()
                let isArrayContain = item.title.lowercased().range(of: text)
                if isArrayContain != nil {
                    print("Search complete")
                    filteredData.append(item)
                }
            }
            if filteredData.count == 0 {
                tableView.backgroundView = nil
            }
            tableView.reloadData()
        }
        
    }
}
