//
//  JsonArrayResult.swift
//  ASNet
//
//  Created by Amit Sen on 11/3/17.
//  Copyright © 2017 Amit Sen. All rights reserved.
//

import Foundation

enum JsonArrayResult<T> {
    case success([T], Any)
    case error(String, String)
}
