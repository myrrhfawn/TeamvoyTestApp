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
    
    var params = ["q": "popular",
            "sortBy": nil,
            "from": nil,
            "to": nil,
    ]
    
    
    
    func setParams(key: String, value: String) -> Void {
        params[key] = value
    }

    let baseUrl = "https://newsapi.org/v2/everything"
    
    @objc func didGetNotification(_ notification: Notification){
        let sortBy = notification.object as! String?
        params["sortBy"] = sortBy
    }
    
    func getArticles(completion: @escaping([Article]) -> Void){
        print("get articles")
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_ :)), name: Notification.Name("params"), object: nil)
        
        var urlWithParams = ""
        for (key, value) in params {
            if value != nil {
                if key == "q"{
                    urlWithParams = baseUrl + "?\(key)=\(value!)"
                } else {
                    urlWithParams = urlWithParams + "&\(key)=\(value!)"
                }
            }
        }
        let url = URL(string: urlWithParams)!
        var request = URLRequest(url: url)
        request.addValue("d1ade120399d4ef29d726e32d9d058d6", forHTTPHeaderField: "x-api-key")
        
        print(url)
        
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

