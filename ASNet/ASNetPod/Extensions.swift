//
//  UIView+Animation.swift
//  UDOY
//
//  Created by Bluscheme on 5/24/17.
//  Copyright © 2017 UDOY TECHNOLOGIES. All rights reserved.
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
