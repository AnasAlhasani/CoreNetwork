//
//  AlamofireManager.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 2/15/19.
//  Copyright © 2019 Anas Alhasani. All rights reserved.
//

import Foundation
import Alamofire

enum AlamofireManager {
   
   static var `default`: Alamofire.SessionManager = {
      return Alamofire.SessionManager(configuration: .default)
   }()
   
   
   static func handleAuthChallenge() {
      
      let delegate = AlamofireManager.default.delegate
      
      delegate.sessionDidReceiveChallenge = { session, challenge in
         
         var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
         
         var credential: URLCredential?
         
         if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            disposition = URLSession.AuthChallengeDisposition.useCredential
            credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
         } else {
            if challenge.previousFailureCount > 0 {
               disposition = .cancelAuthenticationChallenge
            } else {
               credential = AlamofireManager.default.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
               if credential != nil {
                  disposition = .useCredential
               }
            }
         }
         return (disposition, credential)
      }
   }
}
