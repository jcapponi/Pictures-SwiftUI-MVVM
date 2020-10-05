//
//  ViewModelDataSource.swift
//  Pictures-SwiftUI
//
//  Created by Juan Capponi on 9/25/20.
//

import Foundation
import UIKit
import Combine

class ViewModelDataSource {
    
    init(){}
    
    var components : URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.pexels.com"
        components.path = "/v1/search"
        components.queryItems = [URLQueryItem(name: "query", value: "nature"), URLQueryItem(name: "per_page", value: "20")]
        
        return components
    }
    
    func fetchPictures() -> AnyPublisher<JsonPictures, Error> {
        
        var request = URLRequest(url: (components.url)!)
        request.httpMethod = "GET"

        let headers = Constants.headers
        request.allHTTPHeaderFields = headers
       
        return URLSession.shared.dataTaskPublisher(for: request).map() {
            $0.data
           }
        .decode(type: JsonPictures.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
 }


struct ViewModelPictures : Hashable {

    init(photographerName: String, urlSmall : String, medium: String, large: String) {
        self.photographerName = photographerName
        self.medium = medium
        self.large = large
    }
    let photographerName: String
    let medium : String
    let large: String
}

