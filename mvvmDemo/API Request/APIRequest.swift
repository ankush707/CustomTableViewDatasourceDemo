//
//  APIRequest.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import Foundation
import UIKit
import UniformTypeIdentifiers
import MobileCoreServices

enum APICallType: String {
    
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case DELETE = "DELETE"
}

//For dependency Inversion
protocol APICallProtocol {
    func genericApiCall<T: Decodable>(urlStr: String , type: APICallType, completionHandler: @escaping (T) -> () )
}

protocol PrintDataProtocol {
    func printData()
}

class GenericAPIService : NSObject, APICallProtocol {
    
    func printData() {
        print("ANkush")
    }
    
    func genericApiCall<T: Decodable>(urlStr: String , type: APICallType, completionHandler: @escaping (T) -> () ) {
        let url = urlStr
        
        var urlRequest = URLRequest.init(url: URL.init(string: url)!)
        
        urlRequest.httpMethod = type.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let data {
                
                if let placesData = try? JSONDecoder().decode(T.self, from: data) {
                    completionHandler(placesData)
                } else {
                    print(error?.localizedDescription as Any)
                }
            
            }
        }.resume()
    }
}
