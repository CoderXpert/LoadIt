//
//  MockNilURLRequestNetworkJSONResource.swift
//  LoadIt
//
//  Created by Luciano Marisi on 20/07/2016.
//  Copyright © 2016 Luciano Marisi. All rights reserved.
//

import Foundation
@testable import LoadIt

struct MockNilURLRequestNetworkJSONResource: NetworkJSONResourceType {
  typealias Model = String
  let url: URL = URL(string: "www.test.com")!
  func urlRequest() -> URLRequest? {
    return nil
  }
}
