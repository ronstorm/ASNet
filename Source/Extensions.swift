//
//  UIView+Animation.swift
//  UDOY
//
//  Created by Amit Sen on 5/24/17.
//  Copyright © 2017 Amit Sen. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
