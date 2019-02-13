//
//  NetworkService.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveKit
import DynamicJSON

class NetworkService {
    
    var coreDataManager: CoreDataManager!
    
    func requestJSON(
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> Signal<JSON, NetworkError> {
        
        return Signal(producer: { [weak self] (observer) -> Disposable in
            
            let request = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate()
                .responseJSON { [weak self] (response) in
                    switch response.result {
                    case .failure(let error):
                        observer.failed(self?.parseError(error as NSError) ?? .other)
                    case .success(let value):
                        observer.completed(with: JSON(value))
                    }
            }
            
            return BlockDisposable {
                request.cancel()
            }
        })
    }
    
    func requestData(
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> Signal<Data, NetworkError> {
        
        return Signal(producer: { [weak self] (observer) -> Disposable in
            debugPrint("Start loading picture \(url)")
            let request = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate()
                .responseData(completionHandler: { (response) in
                    debugPrint("Complete loading picture \(url)")
                    switch response.result {
                    case .failure(let error):
                        observer.failed(self?.parseError(error as NSError) ?? .other)
                    case .success(let value):
                        observer.completed(with: value)
                    }
                })
            
            return BlockDisposable {
                request.cancel()
            }
        })
    }

    private func parseError(_ nsError: NSError) -> NetworkError {
        return .other
    }
}
