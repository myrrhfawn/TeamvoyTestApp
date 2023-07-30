//
//  ArticleCell.swift
//  TeamvoyTestTask
//
//  Created by Ростик on 30.07.2023.
//

import Foundation

import UIKit

class ArticleCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private var ArticleTitle: UILabel!
    @IBOutlet private var ArticleDescription: UILabel!
    
    // MARK: - Public
    func configure(with title: String, description: String){
        ArticleTitle.text = title
        ArticleDescription.text = description
    }
}
