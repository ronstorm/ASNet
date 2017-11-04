//
//  ImageFile.swift
//  Insuree Agent
//
//  Created by Bluscheme on 9/13/17.
//  Copyright © 2017 amitsen. All rights reserved.
//

import UIKit

typealias ImageFileArray = [ImageFile]

class ImageFile: NSObject {
    internal var imageData: Data
    internal var fileKey: String
    internal var fileName: String
    internal var mimeType: MimeType
    
    init?(image: UIImage, fileKey: String, fileName: String, mimeType: MimeType) {
        
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
