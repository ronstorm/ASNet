//
//  UdoyError.swift
//  UDOY
//
//  Created by Amit Sen on 6/12/17.
//  Copyright © 2017 Amit Sen. All rights reserved.
//

import Foundation

open class ASNetErrorTexts {
    public var requestErrorTitle = "Bad Request!"
    public var responseErrorTitle = "Parse Error!"
    public var serverErrorTitle = "Server Error!"
    public var networkErrorTitle = "Network Error!"
    public var timeoutErrorTitle = "Network Error!"
    public var customErrorTitle = "Error!"
    public var parsingErrorTitle = "Parsing Error!"
    
    public var requestErrorText = "Please, check your request parameters!"
    public var responseErrorText = "Something went wrong with parsing response data!"
    public var serverErrorText = "Something went wrong on the Server Side."
    public var networkErrorText = "Network is not connected!"
    public var timeoutErrorText = "Request timed out! Please check your internet connection!"
    public var parsingErrorText = "Data parsing failed because of invalid format!"
    
    public init() {
        
    }
}
