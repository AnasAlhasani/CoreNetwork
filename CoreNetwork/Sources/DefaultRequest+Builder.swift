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
   public var urlParameters: JSONDictionary
   public var httpBody: Data?
   public var bodyEncoding: HTTPBodyEncoder
   
   public init(
      path: String = "",
      method: HTTPMethod = .get,
      headers: HeadersDictionary = [:],
      urlParameters: JSONDictionary = [:],
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
   public func urlParameters(_ urlParameters: JSONDictionary) -> RequestBuilder {
      defaultRequest.urlParameters = urlParameters
      return self
   }
   
   @discardableResult
   public func encode<T: Encodable>(_ encodable: T, bodyEncoding: HTTPBodyEncoder = .jsonEncoding) -> RequestBuilder {
      guard let httpBody = try? bodyEncoding.encode(encodable) else { return self }
      defaultRequest.bodyEncoding = bodyEncoding
      defaultRequest.httpBody = httpBody
      return self
   }
   
   public func build() -> DefaultRequest<Response> {
      return defaultRequest
   }
}
