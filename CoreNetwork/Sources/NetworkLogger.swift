//
//  NetworkLogger.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

enum NetworkLogger {
   
   static func log(request: URLRequest) {
      
      print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
      defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
      
      let urlString = request.url?.absoluteString ?? ""
      let urlComponents = URLComponents(string: urlString)
      
      let scheme = urlComponents?.scheme ?? "N/A"
      let host = urlComponents?.host ?? "N/A"
      let method = request.httpMethod ?? "N/A"
      let path = urlComponents?.path ?? "N/A"
      let query = urlComponents?.query ?? "N/A"
      let headers = request.allHTTPHeaderFields?.jsonString ?? "N/A"
      let body = request.httpBody?.jsonDictionary.jsonString ?? "N/A"
      
      let logOutput = """
      Scheme: \(scheme) \n
      Host: \(host) \n
      Method: \(method) \n
      Path: \(path) \n
      Query: \(query) \n
      Headers: \(headers) \n
      Body: \n\(body)
      """
      
      print(logOutput)
      
   }
   
   static func log(data: Data?, response: HTTPURLResponse?) {
      
      print("\n - - - - - - - - - - INGOING - - - - - - - - - - \n")
      defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
      
      let urlString = response?.url?.absoluteString ?? ""
      let urlComponents = URLComponents(string: urlString)
      
      let path = urlComponents?.path ?? "N/A"
      let body = data?.jsonDictionary.jsonString ?? "N/A"
      
      let logOutput = """
      Path: \(path) \n
      Body: \n\(body)
      """
      
      print(logOutput)
   }
}
