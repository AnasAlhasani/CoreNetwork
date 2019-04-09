//
//  NetworkError.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 2/14/19.
//  Copyright © 2019 Anas Alhasani. All rights reserved.
//

import Foundation

enum NetworkError: Error {
   case error(String)
   case missingURL
   case decodingFailed
   case encodingFailed
   case invalidParameter
   case unknown
}

extension NetworkError: LocalizedError {
   
   var errorDescription: String? {
      switch self {
      case let .error(message): return message
      case .missingURL: return "Base URL could not be configured."
      case .decodingFailed: return "Failed to decode response."
      case .encodingFailed: return "Failed to encode parameters."
      case .invalidParameter: return "Invalid Parameter."
      case .unknown: return "Something went wrong, please try again later."
      }
   }
   
}
