//
//  NetworkService.swift
//  ASNet
//
//  Created by Amit Sen on 11/2/17.
//  Copyright © 2017 Amit Sen. All rights reserved.
//

import Foundation
import ObjectMapper

open class NetworkService {
    public var isReachable: Bool = true
    
    private var baseUrl: String = ""
    
    public var timeoutIntervalForRequest: TimeInterval {
        get {
            return session.configuration.timeoutIntervalForRequest
        }
        set {
            session.configuration.timeoutIntervalForRequest = newValue
        }
    }
    
    public let errorTexts = ASNetErrorTexts.init()
    
    
    // set up the session
    public let config = URLSessionConfiguration.default
    public var session: URLSession!
    
    public init(baseURL: String) {
        self.baseUrl = baseURL
        session = URLSession(configuration: config)
        session.configuration.timeoutIntervalForRequest = 30
    }
    
    open func fetchAPIDataWithJsonObjectResponse<T: Mappable>(endpointURL url: String, httpMethod method: HTTPMethod, httpHeader header: HTTPHeader?, parameters params: Parameters?, isMultiPart: Bool = false, filesWhenMultipart files: ImageFileArray?, returningType type: T.Type, callback: @escaping (JsonObjectResult<T>) -> ()) {
        
        
        if isReachable {
            guard let url = URL(string: self.baseUrl + url) else {
                print("Error: cannot create URL")
                callback(JsonObjectResult.error(errorTexts.customErrorTitle, "URL Path mismatch!"))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let boundary = self.generateBoundary()
            
            if isMultiPart {
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            } else {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            if let additionalHeader = header {
                for(key, val) in additionalHeader {
                    request.setValue(val, forHTTPHeaderField: key)
                }
            }
            
            switch method {
            case .post:
                if isMultiPart {
                    let dataBody = createDataBody(withParameters: params, imageFiles: files, boundary: boundary)
                    request.httpBody = dataBody
                } else {
                    if let params = params {
                        let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                        request.httpBody = jsonData
                    }
                }
                break
            case .get:
                break
            case .put:
                break
            case .delete:
                break
            }
            
            session.dataTask(with: request) { (data, response, error) in
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                            
                        let apiData = Mapper<T>().map(JSONObject: json)!
                        callback(JsonObjectResult.success(apiData, json))
                    } catch {
                        print(error.localizedDescription)
                        callback(JsonObjectResult.error(self.errorTexts.parsingErrorTitle, self.errorTexts.parsingErrorText))
                        return
                    }
                } else {
                    callback(JsonObjectResult.error(self.errorTexts.responseErrorTitle, self.errorTexts.responseErrorText))
                    return
                }
                
            }.resume()
        } else {
            callback(JsonObjectResult.error(self.errorTexts.networkErrorTitle, self.errorTexts.networkErrorText))
        }
    }
    
    open func fetchAPIDataWithJsonArrayResponse<T: Mappable>(endpointURL url: String, httpMethod method: HTTPMethod, httpHeader header: HTTPHeader?, parameters params: Parameters?, isMultiPart: Bool = false, filesWhenMultipart files: ImageFileArray?, returningType type: T.Type, callback: @escaping (JsonArrayResult<T>) -> ()) {
        
        
        if isReachable {
            guard let url = URL(string: self.baseUrl + url) else {
                print("Error: cannot create URL")
                callback(JsonArrayResult.error(errorTexts.customErrorTitle, "URL Path mismatch!"))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let boundary = self.generateBoundary()
            
            if isMultiPart {
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            } else {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            if let additionalHeader = header {
                for(key, val) in additionalHeader {
                    request.setValue(val, forHTTPHeaderField: key)
                }
            }
            
            switch method {
            case .post:
                if isMultiPart {
                    let dataBody = createDataBody(withParameters: params, imageFiles: files, boundary: boundary)
                    request.httpBody = dataBody
                } else {
                    if let params = params {
                        let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                        request.httpBody = jsonData
                    }
                }
                break
            case .get:
                break
            case .put:
                break
            case .delete:
                break
            }
            
            session.dataTask(with: request) { (data, response, error) in
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        let apiData = Mapper<T>().mapArray(JSONObject: json)!
                        callback(JsonArrayResult.success(apiData, json))
                    } catch {
                        print(error.localizedDescription)
                        callback(JsonArrayResult.error(self.errorTexts.parsingErrorTitle, self.errorTexts.parsingErrorText))
                        return
                    }
                } else {
                    callback(JsonArrayResult.error(self.errorTexts.responseErrorTitle, self.errorTexts.responseErrorText))
                    return
                }
                
            }.resume()
        } else {
            callback(JsonArrayResult.error(self.errorTexts.networkErrorTitle, self.errorTexts.networkErrorText))
        }
    }
    
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters params: Parameters?, imageFiles: ImageFileArray?, boundary: String) -> Data {
        
        let br = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, val) in parameters {
                if val is String {
                    let value = val as! String
                    body.append("--\(boundary + br)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(br + br)")
                    body.append("\(value + br)")
                }
            }
        }
        
        if let imageFiles = imageFiles {
            for file in imageFiles {
                body.append("--\(boundary + br)")
                body.append("Content-Disposition: form-data; name=\"\(file.fileKey)\"; filename=\"\(file.fileName)\"\(br)")
                body.append("Content-Type: \(file.mimeType.rawValue + br + br)")
                body.append(file.imageData)
                body.append(br)
            }
        }
        
        body.append("--\(boundary)--\(br)")
        
        return body
    }
    
    private func setAdditionalHeader(header: HTTPHeader?) {
        
    }
}
