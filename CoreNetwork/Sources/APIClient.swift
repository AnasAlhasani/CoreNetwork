//
//  APIClient.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation
import Promises

public protocol APIClient {
   
   var configuration: ServiceConfigurator { get }
   
   init(_ configuration: ServiceConfigurator)
   
   func execute<T: APIRequest>(_ request: T) -> Promise<T.Response>
}
