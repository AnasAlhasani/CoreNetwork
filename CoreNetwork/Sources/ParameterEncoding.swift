//
//  ParameterEncoding.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 2/14/19.
//  Copyright © 2019 Anas Alhasani. All rights reserved.
//

import Foundation

enum Parameter {
   case string(String)
   case bool(Bool)
   case int(Int)
   case double(Double)
   case array([Parameter])
   case dictionary([String: Parameter])
}

extension Parameter: Codable {
   init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      
      if let string = try? container.decode(String.self) {
         self = .string(string)
      } else if let bool = try? container.decode(Bool.self) {
         self = .bool(bool)
      } else if let int = try? container.decode(Int.self) {
         self = .int(int)
      } else if let double = try? container.decode(Double.self) {
         self = .double(double)
      } else if let array = try? container.decode([Parameter].self) {
         self = .array(array)
      } else if let dictionary = try? container.decode([String: Parameter].self)  {
         self = .dictionary(dictionary)
      } else {
         throw NetworkError.decodingFailed
      }
   }
   
   func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      
      switch self {
      case let .string(value):
         try container.encode(value)
      case let .bool(value):
         try container.encode(value)
      case let .int(value):
         try container.encode(value)
      case let .double(value):
         try container.encode(value)
      case let .array(value):
         try container.encode(value)
      case let .dictionary(value):
         try container.encode(value)
      }
   }
}

extension Parameter: CustomStringConvertible {
   var description: String {
      switch self {
      case .string(let string):
         return string
      case .bool(let bool):
         return String(describing: bool)
      case .int(let int):
         return String(describing: int)
      case .double(let double):
         return String(describing: double)
      case .array(let array):
         return String(describing: array)
      case .dictionary(let dictionary):
         let jsonString = dictionary.mapValues { $0.description }.jsonString
         return  jsonString ?? String(describing: dictionary)
      }
   }
}

public enum HTTPBodyEncoder {
   case urlEncoding
   case jsonEncoding
   
   public func encode<T: Encodable>(_ encodable: T) throws -> Data {
      do {
         switch self {
         case .jsonEncoding:
            return try encodable.encode()
         case .urlEncoding:
            let queryString = try URLQueryEncoder.queryString(encodable)
            if let data = queryString.data(using: .utf8, allowLossyConversion: false) {
               return data
            } else {
               throw NetworkError.encodingFailed
            }
         }
      } catch {
         throw NetworkError.encodingFailed
      }
   }
}

enum URLQueryEncoder {
   static func queryString<T: Encodable>(_ encodable: T) throws -> String {
      let data: Data = try encodable.encode()
      let parameters: [String: Parameter] = try data.decode()
      return parameters.map { "\($0)=\($1.description)" }.joined(separator: "&")
   }
   
   static func queryItems(_ data: Data) throws -> [URLQueryItem] {
      let parameters: [String: Parameter] = try data.decode()
      return parameters.map { URLQueryItem(name: $0, value: $1.description) }
   }
}
