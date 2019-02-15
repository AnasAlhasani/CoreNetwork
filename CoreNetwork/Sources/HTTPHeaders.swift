//
//  HTTPHeaders.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 2/14/19.
//  Copyright © 2019 Anas Alhasani. All rights reserved.
//

import Foundation

public enum HTTPHeaders: String {
   case contentType = "Content-Type"
   case accept = "Accept"
   case authorization = "Authorization"
   
   func value(_ encoding: HTTPBodyEncoder) -> String {
      switch encoding {
      case .jsonEncoding: return "application/json"
      case .urlEncoding: return "application/x-www-form-urlencoded; charset=utf-8"
      }
   }
}
