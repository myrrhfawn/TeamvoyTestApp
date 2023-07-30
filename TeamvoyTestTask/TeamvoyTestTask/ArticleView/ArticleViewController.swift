//
//  ArticleViewController.swift
//  TeamvoyTestTask
//
//  Created by Ростик on 30.07.2023.
//

import Foundation
import UIKit




class ArticleViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private var articleImage: UIImageView!
    @IBOutlet private var articleInfo: UILabel!
    @IBOutlet private var articleSource: UILabel!
    @IBOutlet private var articleTitle: UILabel!
    @IBOutlet private var articleDescription: UILabel!
    
    var selectedArticle : Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleImage.download(from: selectedArticle.urlToImage!)
        articleTitle.text = selectedArticle.title
        articleDescription.text = selectedArticle.description
        let dateFormatterToDate = ISO8601DateFormatter()
        let date = dateFormatterToDate.date(from: selectedArticle.publishedAt)
        let dateFormatterToString = DateFormatter()
        dateFormatterToString.dateFormat = "y MMM d, hh:mm"
        
        articleInfo.text = "\(selectedArticle.author!), \(dateFormatterToString.string(from: date!))"
        
    }
    
    
    
}

extension UIImageView {
    func download(from url:URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit){
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
}
