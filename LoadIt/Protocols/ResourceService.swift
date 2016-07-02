//
//  ResourceService.swift
//  LoadIt
//
//  Created by Luciano Marisi on 02/07/2016.
//  Copyright © 2016 Luciano Marisi. All rights reserved.
//

import Foundation

public protocol ResourceService {
  associatedtype ResourceType: Resource
  /**
   Fetch the resource
   
   - parameter resource:   The resource to fetch
   - parameter completion: A completion handler called with a Result type of the fetching computation
   */
  func fetch(resource resource: ResourceType, completion: (Result<ResourceType.ModelType>) -> Void)
}