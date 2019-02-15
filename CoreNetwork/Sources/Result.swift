//
//  Result.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

public enum Result<Value> {
   case success(Value)
   case failure(Error)
}
