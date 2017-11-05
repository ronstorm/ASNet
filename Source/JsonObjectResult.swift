//
//  Result.swift
//  UDOY
//
//  Created by Amit Sen on 6/12/17.
//  Copyright © 2017 Amit Sen. All rights reserved.
//

import Foundation

public enum JsonObjectResult<T> {
    case success(T, Any)
    case error(String, String)
}
