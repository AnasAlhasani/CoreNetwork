//
//  DefaultAPIClient.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation
import Alamofire
import Promises

public final class DefaultAPIClient: APIClient {
   
   public var configuration: ServiceConfigurator
   
   required public init(_ configuration: ServiceConfigurator = ServiceConfigurator()) {
      self.configuration = configuration
   }
   
   public func execute<T: APIRequest>(_ request: T) -> Promise<T.Response> {
      let urlRequest = request.urlRequest(in: self)
      let dataRequest = AlamofireManager.default.request(urlRequest)
      AlamofireManager.handleAuthChallenge()
      NetworkLogger.log(request: urlRequest)
      
      return Promise<T.Response>(on: .global(qos: .background)) { (fullfill, reject) in
         dataRequest.validate().responseJSON { response in
            NetworkLogger.log(data: response.data, response: response.response)
            if let data = response.data {
               do {
                  let object = try JSONDecoder().decode(T.Response.self, from: data)
                  fullfill(object)
               } catch {
                  reject(NetworkError.decodingFailed)
               }
            } else if let error = response.error {
               reject(NetworkError.error(error.localizedDescription))
            } else {
               reject(NetworkError.unknown)
            }
         }
      }
   }
   
}
