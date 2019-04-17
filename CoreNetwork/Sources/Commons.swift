//
//  Commons.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

// MARK: - Typealias

public typealias JSONDictionary = [String: Any]
public typealias HeadersDictionary = [String: String]

// MARK: - Extensions

extension Data {
   var jsonDictionary: JSONDictionary? {
      do {
         let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
         return jsonObject as? JSONDictionary
      } catch {
         return nil
      }
   }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
   var jsonString: String? {
      do {
         let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
         return String(bytes: data, encoding: .utf8)
      } catch {
         return nil
      }
   }
}

extension Data {
   func decode<T: Decodable>(using decoder: JSONDecoder = .init()) throws -> T {
      return try decoder.decode(T.self, from: self)
   }
}

extension Encodable {
   func encode(using encoder: JSONEncoder = .init()) throws -> Data {
      return try encoder.encode(self)
   }
   
   func encode(using encoder: JSONEncoder = .init()) throws -> JSONDictionary? {
      let data: Data = try encode(using: encoder)
      return try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
   }
}
