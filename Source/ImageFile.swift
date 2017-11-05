//
//  ImageFile.swift
//  Insuree Agent
//
//  Created by Amit Sen on 9/13/17.
//  Copyright © 2017 Amit Sen. All rights reserved.
//

import UIKit

typealias ImageFileArray = [ImageFile]

open class ImageFile: NSObject {
    public var imageData: Data
    public var fileKey: String
    public var fileName: String
    public var mimeType: MimeType
    
    public init?(image: UIImage, fileKey: String, fileName: String, mimeType: MimeType) {
        
        self.fileKey = fileKey
        self.fileName = fileName
        self.mimeType = mimeType
        
        switch mimeType {
        case .jpg:
            guard let data = UIImageJPEGRepresentation(image, 0.7) else { return nil
            }
            self.imageData = data
            break
        case .png:
            guard let data = UIImagePNGRepresentation(image) else {
                return nil
            }
            self.imageData = data
            break
        }
        
        super.init()
    }
}
