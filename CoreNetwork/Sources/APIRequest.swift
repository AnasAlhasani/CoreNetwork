//
//  APIRequest.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol APIRequest {
   
   associatedtype Response: Decodable
   
   var path: String { get }
   var method: HTTPMethod { get }
   var headers: HeadersDictionary { get }
   var urlParameters: Data? { get }
   var httpBody: Data? { get }
   var bodyEncoding: HTTPBodyEncoder { get }
   func urlRequest(in apiClient: APIClient) -> URLRequest
}

public extension APIRequest {
   var headers: HeadersDictionary {
      return [:]
   }
   
   var urlParameters: Data? {
      return nil
   }
   
   var httpBody: Data? {
      return nil
   }
   
   var bodyEncoding: HTTPBodyEncoder {
      return .jsonEncoding
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
      urlRequest.httpBody = httpBody
      return urlRequest
   }
}

internal extension APIRequest {
   func url(in apiClient: APIClient) -> URL {
      let url = apiClient.configuration.url.appendingPathComponent(path)
      guard let urlParameters = urlParameters else { return url }
      var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
      urlComponents?.queryItems = try? URLQueryEncoder.queryItems(urlParameters)
      return urlComponents?.url ?? url
   }
   
   func headers(in apiClient: APIClient) -> HeadersDictionary {
      var headers = apiClient.configuration.headers
      self.headers.forEach { headers[$0.key] = $0.value }
      guard headers[HTTPHeaders.contentType.rawValue] == nil, httpBody != nil else { return headers }
      headers[HTTPHeaders.contentType.rawValue] = HTTPHeaders.contentType.value(bodyEncoding)
      return headers
   }
}
