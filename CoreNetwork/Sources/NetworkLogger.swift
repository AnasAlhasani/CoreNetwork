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
      
      let scheme = urlComponents?.scheme ?? ""
      let host = urlComponents?.host ?? ""
      let method = request.httpMethod ?? ""
      let path = urlComponents?.path ?? ""
      let query = urlComponents?.query ?? ""
      
      var logOutput = """
      \(scheme)://\(host) \n
      \(method) \(path)\(query.isEmpty ? "" : "?")\(query) \n
      """
      
      guard let httpBody = request.httpBody else {
         print(logOutput)
         return
      }
      
      if let json = httpBody.jsonDictionary?.jsonString {
         logOutput += "\nBody: \n\(json)"
      } else if let parameters: [String: HTTPParameter] = try? httpBody.decode() {
         logOutput += "\nBody: \n\(parameters.mapValues { $0.description })"
      }
      
      print(logOutput)
   }
   
   static func log(data: Data?, response: HTTPURLResponse?) {
      
      print("\n - - - - - - - - - - INGOING - - - - - - - - - - \n")
      defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
      
      let urlString = response?.url?.absoluteString ?? ""
      let urlComponents = URLComponents(string: urlString)
      
      let path = urlComponents?.path ?? "N/A"
      let body = data?.jsonDictionary?.jsonString ?? "N/A"
      
      let logOutput = """
      Path: \(path) \n
      Body: \n\(body)
      """
      
      print(logOutput)
   }
}
