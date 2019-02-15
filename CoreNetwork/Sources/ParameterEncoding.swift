//
//  ParameterEncoding.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 2/14/19.
//  Copyright © 2019 Anas Alhasani. All rights reserved.
//

import Foundation

enum HTTPParameter {
   case string(String)
   case bool(Bool)
   case int(Int)
   case double(Double)
   
   init(value: Any) throws {
      switch value {
      case let stringValue as String:
         self = .string(stringValue)
      case let boolValue as Bool:
         self = .bool(boolValue)
      case let intValue as Int:
         self = .int(intValue)
      case let doubleValue as Double:
         self = .double(doubleValue)
      default:
         throw NetworkError.invalidParameter
      }
   }
}

extension HTTPParameter: Codable {
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
      }
   }
}

extension HTTPParameter: CustomStringConvertible {
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
      }
   }
}

public enum HTTPBodyEncoder {
   case urlEncoding
   case jsonEncoding
   
   public func encode<T: Encodable>(_ encodable: T) throws -> Data? {
      do {
         switch self {
         case .jsonEncoding:
            return try encodable.encode()
         case .urlEncoding:
            return try URLQueryEncoder.encode(encodable).data(using: .utf8, allowLossyConversion: false)
         }
      } catch {
         throw NetworkError.encodingFailed
      }
   }
}

enum URLQueryEncoder {
   
   static func encode<T: Encodable>(_ encodable: T) throws -> String {
      return try encode(encodable).map { "\($0)=\($1.description)" }.joined(separator: "&")
   }
   
   static func encode<T: Encodable>(_ encodable: T) throws -> [URLQueryItem] {
      return try encode(encodable).map { URLQueryItem(name: $0, value: $1.description) }
   }
   
   private static func encode<T: Encodable>(_ encodable: T) throws -> [String: HTTPParameter] {
      let data: Data = try encodable.encode()
      return try JSONDecoder().decode([String: HTTPParameter].self, from: data)
   }
}
