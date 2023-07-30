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
    
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
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


}

// MARK: -UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.configure(with: articles[indexPath.row].title, description: articles[indexPath.row].description)
        return cell
    }
}

