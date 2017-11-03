//
//  Result.swift
//  UDOY
//
//  Created by Bluscheme on 6/12/17.
//  Copyright © 2017 UDOY TECHNOLOGIES. All rights reserved.
//

import Foundation

enum JsonObjectResult<T> {
    case success(T, Any)
    case error(String, String)
}
