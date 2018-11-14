//
//  ServiceConfigurator.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

public final class ServiceConfigurator {
   
   private enum ConfigKeys {
      static let server = "ServerConfiguration"
      static let baseURL = "baseURL"
      static let headers = "headers"
   }
   
   private(set) var url: URL
   public var headers: HeadersDictionary = [:]
   public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
   public var timeout: TimeInterval = 15.0
   
   public init(baseURL: String?) {
      guard let stringURL = baseURL, let url = URL(string: stringURL) else {
         fatalError("baseURL could not be configured.")
      }
      self.url = url
   }
   
   public convenience init() {
      guard let infoDictionary = Bundle.main.infoDictionary,
         let serverConfiguration = infoDictionary[ConfigKeys.server] as? JSONDictionary else {
            fatalError("missing key for: ServerConfiguration dictionary")
      }
      let baseURL = serverConfiguration[ConfigKeys.baseURL] as? String
      self.init(baseURL: baseURL)
      let headers = serverConfiguration[ConfigKeys.headers] as? HeadersDictionary
      headers?.forEach { self.headers[$0.key] = $0.value }
   }
   
}
