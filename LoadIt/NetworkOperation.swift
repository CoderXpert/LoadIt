//
//  NetworkOperation.swift
//  LoadIt
//
//  Created by Luciano Marisi on 25/06/2016.
//  Copyright © 2016 Luciano Marisi. All rights reserved.
//

import Foundation

public protocol NetworkOperation: ResourceOperation {
  associatedtype ResourceType: NetworkResource
  var networkService: NetworkService<ResourceType> { get }
}


public extension NetworkOperation {
  
  public func fetchResource() {
    if cancelled { return }
    networkService.fetchResource(resource) { [weak self] (result) in
      guard let strongSelf = self else { return }
      if strongSelf.cancelled { return }
      NSThread.executeOnMain { [weak self] in
        guard let strongSelf = self else { return }
        if strongSelf.cancelled { return }
        strongSelf.finishedWithResult(result)
        strongSelf.finish([])
      }
    }
  }
  
}

