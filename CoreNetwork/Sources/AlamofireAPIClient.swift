//
//  AlamofireAPIClient.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 11/15/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Alamofire

public final class AlamofireAPIClient: APIClient {
   
   public var configuration: ServiceConfigurator
   
   required public init(_ configuration: ServiceConfigurator = ServiceConfigurator()) {
      self.configuration = configuration
   }
   
   public func execute<T: APIRequest>(_ request: T, completion: @escaping ResultCompletion<T.Response>) {
      
      let urlRequest = request.urlRequest(in: self)
      
      let dataRequest = AlamofireAPIClient.manager.request(request.urlRequest(in: self))
      
      handleAuthChallenge()
      
      NetworkLogger.log(request: urlRequest)
      
      dataRequest.validate().responseJSON { response in
         
         NetworkLogger.log(data: response.data, response: response.response)
         
         if let error = response.error {
            completion(.failure(error.localizedDescription))
         } else if let data = response.data {
            do {
               let apiResponse = try JSONDecoder().decode(T.Response.self, from: data)
               completion(.success(apiResponse))
            } catch {
               completion(.failure(error.localizedDescription))
            }
         } else {
            completion(.failure("Something went wrong, please try again later."))
         }
      }
   }
   
}

// MARK: - AuthChallenge

private extension AlamofireAPIClient {
   
   static var manager: Alamofire.SessionManager = {
      return Alamofire.SessionManager(configuration: .default)
   }()
   
   func handleAuthChallenge() {
      
      let delegate = AlamofireAPIClient.manager.delegate
      
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
               credential = AlamofireAPIClient.manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
               if credential != nil {
                  disposition = .useCredential
               }
            }
         }
         return (disposition, credential)
      }
   }
}
