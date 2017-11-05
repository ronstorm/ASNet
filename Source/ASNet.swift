//
//  ASNet.swift
//  ASNet
//
//  Created by Amit Sen on 11/2/17.
//  Copyright © 2017 Amit Sen. All rights reserved.
//

import Foundation
import ObjectMapper

typealias Parameters = [String: Any]

open class ASNet {
    private var host: String = ""
    private var baseURL: String = ""
    
    public var reachability: Reachability?
    
    public static let shared = ASNet()
    
    public var networkService: NetworkService!
    
    private init() {
        
    }
    
    open func initialize(withHost host: String, andBaseURL baseURL: String) {
        self.host = host
        self.baseURL = baseURL
        networkService = NetworkService(baseURL: self.baseURL)
        setReachability()
    }
    
    private func setReachability() {
        reachability = Reachability(hostname: host)
        
        reachability?.whenReachable = { reachability in
            print("when reachable")
            self.networkService.isReachable = true
        }
        
        reachability?.whenUnreachable = { reachability in
            print("when unreachable")
            self.networkService.isReachable = false
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    deinit {
        reachability?.stopNotifier()
    }
    
    open func fetchAPIDataWithJsonObjectResponse<T: Mappable>(endpointURL url: String, httpMethod method: HTTPMethod, parameters params: Parameters?, isMultiPart: Bool = false, filesWhenMultipart files: ImageFileArray?, returningType type: T.Type, callback: @escaping (JsonObjectResult<T>) -> ()) {
        
        networkService.fetchAPIDataWithJsonObjectResponse(endpointURL: url, httpMethod: method, parameters: params, isMultiPart: isMultiPart, filesWhenMultipart: files, returningType: type) { (result) in
            callback(result)
        }
    }
    
    open func fetchAPIDataWithJsonArrayResponse<T: Mappable>(endpointURL url: String, httpMethod method: HTTPMethod, parameters params: Parameters?, isMultiPart: Bool = false, filesWhenMultipart files: ImageFileArray?, returningType type: T.Type, callback: @escaping (JsonArrayResult<T>) -> ()) {
        
        networkService.fetchAPIDataWithJsonArrayResponse(endpointURL: url, httpMethod: method, parameters: params, isMultiPart: isMultiPart, filesWhenMultipart: files, returningType: type) { (result) in
            callback(result)
        }
    }
}
