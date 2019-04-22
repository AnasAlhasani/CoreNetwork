//
//  DefaultRequest+Builder.swift
//  CoreNetwork
//
//  Created by Anas Alhasani on 2/14/19.
//  Copyright © 2019 Anas Alhasani. All rights reserved.
//

import Foundation

public struct DefaultRequest<ResponseType: Decodable>: APIRequest {
   
   public typealias Response = ResponseType
   
   public var path: String
   public var method: HTTPMethod
   public var headers: HeadersDictionary
   public var urlParameters: Data?
   public var httpBody: Data?
   public var bodyEncoding: HTTPBodyEncoder
   
   public init(
      path: String = "",
      method: HTTPMethod = .get,
      headers: HeadersDictionary = [:],
      urlParameters: Data? = nil,
      httpBody: Data? = nil,
      bodyEncoding: HTTPBodyEncoder = .jsonEncoding
      ) {
      self.path = path
      self.method = method
      self.headers = headers
      self.urlParameters = urlParameters
      self.httpBody = httpBody
      self.bodyEncoding = bodyEncoding
   }
}

public class RequestBuilder<Response: Decodable> {
   
   private var defaultRequest: DefaultRequest<Response>
   
   public init() {
      self.defaultRequest = DefaultRequest<Response>()
   }
   
   @discardableResult
   public func path(_ path: String) -> RequestBuilder {
      defaultRequest.path = path
      return self
   }
   
   @discardableResult
   public func method(_ method: HTTPMethod) -> RequestBuilder {
      defaultRequest.method = method
      return self
   }
   
   @discardableResult
   public func headers(_ headers: HeadersDictionary) -> RequestBuilder {
      defaultRequest.headers = headers
      return self
   }
   
   @discardableResult
   public func urlParameters<T: Encodable>(_ urlParameters: T) -> RequestBuilder {
      defaultRequest.urlParameters = try? urlParameters.encode()
      return self
   }
   
   @discardableResult
   public func encode<T: Encodable>(_ encodable: T, bodyEncoding: HTTPBodyEncoder = .jsonEncoding) -> RequestBuilder {
      defaultRequest.bodyEncoding = bodyEncoding
      defaultRequest.httpBody = try? bodyEncoding.encode(encodable)
      return self
   }
   
   public func build() -> DefaultRequest<Response> {
      return defaultRequest
   }
}
