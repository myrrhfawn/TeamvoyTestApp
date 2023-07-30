//
//  APIManager.swift
//  TeamvoyTestTask
//
//  Created by Ростик on 30.07.2023.
//  APIKEY: d1ade120399d4ef29d726e32d9d058d6
//  BaseUrl: https://newsapi.org/v2/everything?q=popular
import Foundation
import UserNotifications

class APIManager {
    static let shared = APIManager()
    
    var params = ["q": "popular",
            "sortBy": nil,
            "from": nil,
            "to": nil,
    ]
    
    

    let baseUrl = "https://newsapi.org/v2/everything"
    
    @objc func didGetNotification(_ notification: Notification){
        let sortBy = notification.object as! String?
        params["sortBy"] = sortBy
    }
    @objc func setFromDate(_ notification: Notification){
        let from = notification.object as! String?
        params["from"] = from
    }
    @objc func setToDate(_ notification: Notification){
        let to = notification.object as! String?
        params["to"] = to
    }
    
    func getArticles(completion: @escaping([Article]) -> Void){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_ :)), name: Notification.Name("params"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setFromDate(_ :)), name: Notification.Name("setFromDate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setToDate(_ :)), name: Notification.Name("setToDate"), object: nil)
        var urlWithParams = baseUrl + "?q=\(params["q"]!!)"
        for (key, value) in params {
            if value != nil {
                if key != "q"{
                    urlWithParams = urlWithParams + "&\(key)=\(value!)"
                }
            }
        }
        let url = URL(string: urlWithParams)!
        var request = URLRequest(url: url)
        
        //API KEY
        request.addValue("d1ade120399d4ef29d726e32d9d058d6", forHTTPHeaderField: "x-api-key")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {return}
            if let articlesData = try? JSONDecoder().decode(ArticlesData.self, from: data){
                completion(articlesData.articles)
            }
        }
        task.resume()
    }
    
}

