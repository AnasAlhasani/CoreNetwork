//
//  APIRequest.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol APIRequest: Encodable {
   
   associatedtype Response: Decodable
   
   var method: RequestMethod { get }
   var path: String { get }
   var headers: HeadersDictionary { get }
   var urlParameters: JSONDictionary { get }
   func headers(in apiClient: APIClient) -> HeadersDictionary
   func url(in apiClient: APIClient) -> URL
   func urlRequest(in apiClient: APIClient) -> URLRequest
}

public extension APIRequest {
   
   var headers: HeadersDictionary {
      return [:]
   }
   
   var urlParameters: JSONDictionary {
      return [:]
   }
   
   func headers(in apiClient: APIClient) -> HeadersDictionary {
      var headers = apiClient.configuration.headers
      self.headers.forEach { headers[$0.key] = $0.value }
      return headers
   }
   
   func url(in apiClient: APIClient) -> URL {
      let parameters = URLQueryEncoder.encode(urlParameters)
      let url = apiClient.configuration.url.appendingPathComponent(path)
      return URL(string: "\(url.absoluteString)?\(parameters)") ?? url
   }
   
   func urlRequest(in apiClient: APIClient) -> URLRequest {
      
      let requestURL = url(in: apiClient)
      let cachePolicy = apiClient.configuration.cachePolicy
      let timeout = apiClient.configuration.timeout
      
      var urlRequest = URLRequest(
         url: requestURL,
         cachePolicy: cachePolicy,
         timeoutInterval: timeout
      )
      
      urlRequest.httpMethod = method.rawValue
      urlRequest.allHTTPHeaderFields = headers(in: apiClient)
      urlRequest.httpBody = try? JSONEncoder().encode(self)
      return urlRequest
   }
   
}
