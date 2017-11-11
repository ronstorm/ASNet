//
//  ViewController.swift
//  ASNet
//
//  Created by Amit Sen on 11/2/17.
//  Copyright © 2017 Amit Sen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // to check if the host is reachable or not.
    let host = "www.google.com"
    
    let baseUrl = "https://www.google.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let asNet = ASNet.shared
        asNet.initialize(withHost: host, andBaseURL: baseUrl)
        asNet.networkService.timeoutIntervalForRequest = 60
        
        asNet.networkService.errorTexts.customErrorTitle = "Yo! It's a custom error title!"
        
        let apiUrl = "/api/getJson"
        
        let imageUrl = "https://fyf.tac-cdn.net/images/products/large/TEV12-4.jpg"
        
        // For Object Response
        asNet.fetchAPIDataWithJsonObjectResponse(endpointURL: apiUrl, httpMethod: .get, httpHeader: nil, parameters: nil, isMultiPart: false, filesWhenMultipart: nil, returningType: Lead.self) { (result) in
            
            switch result {
            case .success(let lead, let json):
                // lead is an object of Lead model.
                // json is the the json response of the request. this response is not needed unless you want to do something special with this. The library is parsing your data itself and returning you the object of the class type you are sending through parameters you want.
                break
            case .error(let errorTitle, let errorText):
                // you can edit this errortitle and errortext.
                break
            }
        }
        
        // for array response
        asNet.fetchAPIDataWithJsonArrayResponse(endpointURL: apiUrl, httpMethod: .get, httpHeader: nil, parameters: nil, isMultiPart: false, filesWhenMultipart: nil, returningType: Lead.self) { (result) in
            
            switch result {
            case .success(let leads, let json):
                // leads is an array of Lead model Objects.
                // json is the the json response of the request. this response is not needed unless you want to do something special with this. The library is parsing your data itself and returning you the array of object of the class type you are sending through parameters you want.
                break
            case .error(let errorTitle, let errorText):
                // you can edit this errortitle and errortext.
                break
            }
        }
        
        // To get an image from url
        asNet.loadImage(fromUrl: imageUrl, usingCache: true, onSuccess: { (image) in
            // do whatever you want with the image
            
        }, onError: {
            // Error downloading image. Show any alert or something.
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

