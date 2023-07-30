//
//  APIManager.swift
//  TeamvoyTestTask
//
//  Created by Ростик on 30.07.2023.
//  APIKEY: d1ade120399d4ef29d726e32d9d058d6
//  BaseUrl: https://newsapi.org/v2/everything?q=popular
import Foundation


class APIManager {
    static let shared = APIManager()
    
    let baseUrl = "https://newsapi.org/v2/everything?q=popular"
    
    func getArticles(completion: @escaping([Article]) -> Void){
        let url = URL(string: baseUrl)!
        var request = URLRequest(url: url)
        request.addValue("d1ade120399d4ef29d726e32d9d058d6", forHTTPHeaderField: "x-api-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {return}
            if let articlesData = try? JSONDecoder().decode(ArticlesData.self, from: data){
                completion(articlesData.articles)
            } else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
}

