//
//  ViewController.swift
//  LoadItExample
//
//  Created by Luciano Marisi on 25/06/2016.
//  Copyright © 2016 Luciano Marisi. All rights reserved.
//

import UIKit
import LoadIt

class ViewController: UIViewController {

  private let operationQueue = NSOperationQueue()

  override func viewDidLoad() {
    super.viewDidLoad()    
    let citiesNetworkJSONOperation = CitiesNetworkJSONOperation(continent: "america", delegate: self)
    operationQueue.addOperation(citiesNetworkJSONOperation)
//    citiesNetworkJSONOperation.cancel()
//    operationQueue.cancelAllOperations()
    
    let citiesDiskJSONOperation = CitiesDiskJSONOperation(continent: "asia", delegate: self)
    operationQueue.addOperation(citiesDiskJSONOperation)
//    citiesDiskJSONOperation.cancel()
//    operationQueue.cancelAllOperations()

    
    let citiesResource = CitiesResource(continent: "europe")
    
    let diskJSONService = DiskJSONService<CitiesResource>()
    diskJSONService.fetch(resource: citiesResource) {[weak self] result in
      self?.log(result: result)
    }
    
    let networkJSONService = NetworkJSONService<CitiesResource>()
    networkJSONService.fetch(resource: citiesResource) { [weak self] result in
      self?.log(result: result)
    }
    
  }
    
  func log(result result: Result<[City]>) {
    if case .Success(let cities) = result {
      print(cities)
    } else {
      print(result)
    }
  }
  
}

extension ViewController: CitiesNetworkJSONOperationDelegate {
  func citiesOperationDidFinish(operation: CitiesNetworkJSONOperation, result: Result<[City]>) {
    if operation.cancelled { return }
    log(result: result)
  }
}

extension ViewController: CitiesDiskJSONOperationDelegate {
  
  func citiesOperationDidFinish(operation: CitiesDiskJSONOperation, result: Result<[City]>) {
    if operation.cancelled { return }
    log(result: result)
  }
  
}
