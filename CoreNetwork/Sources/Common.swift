//
//  Common.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

// MARK: - Typealias

public typealias JSONDictionary = [String: Any]
public typealias HeadersDictionary = [String: String]

// MARK: - RequestMethod

public enum RequestMethod: String {
   case get = "GET"
   case post = "POST"
   case put = "PUT"
   case delete = "DELETE"
}

// MARK: - Query Encoder

enum URLQueryEncoder {
   
   static func encode(_ parameters: JSONDictionary)  -> String {
      return parameters
         .map({ "\($0)=\($1)" })
         .joined(separator: "&")
         .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
   }
}

// MARK: - Extensions

extension Data {
   
   var jsonDictionary: JSONDictionary {
      let jsonObject = try? JSONSerialization.jsonObject(with: self, options: [])
      return jsonObject as? JSONDictionary ?? [:]
   }
   
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
   
   var jsonString: String {
      guard JSONSerialization.isValidJSONObject(self) else {
         return ""
      }
      guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
         return ""
      }
      return String(bytes: jsonData, encoding: .utf8) ?? ""
   }
   
}

