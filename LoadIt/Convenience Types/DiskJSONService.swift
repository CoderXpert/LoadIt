//
//  DiskJSONService.swift
//  LoadIt
//
//  Created by Luciano Marisi on 25/06/2016.
//  Copyright © 2016 Luciano Marisi. All rights reserved.
//

import Foundation

enum DiskJSONServiceError: ErrorType {
  case FileNotFound
  case NoData
}

public struct DiskJSONService<Resource: DiskJSONResourceType> {
  
  private let bundle: Bundle
  
  public init() {
    self.init(bundle: NSBundle.mainBundle())
  }
  
  init(bundle: Bundle) {
    self.bundle = bundle
  }
  
  private func resultFrom(resource resource: Resource) -> Result<Resource.ModelType>{
    guard let url = bundle.URLForResource(resource.filename, withExtension: "json") else {
      return.Failure(DiskJSONServiceError.FileNotFound)
    }
    
    guard let data = NSData(contentsOfURL: url) else {
      return.Failure(DiskJSONServiceError.NoData)
    }
    
    return resource.resultFrom(data: data)
  }
}

// MARK: - ResourceService
extension DiskJSONService: ResourceService {
  
  public func fetch(resource resource: Resource, completion: (Result<Resource.ModelType>) -> Void) {
    completion(resultFrom(resource: resource))
  }
  
}
