//
//  ImageStore.swift
//  Homepwner
//
//  Created by Jose Pacheco on 8/15/18.
//  Copyright © 2018 Jose Pacheco. All rights reserved.
//

import UIKit

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    
    func set(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageUrl(forKey: key)
        if let data = UIImageJPEGRepresentation(image,  0.5) {
            try? data.write(to: url, options: [.atomic])
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        let url = imageUrl(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageUrl(forKey: key)
        try? FileManager.default.removeItem(at: url)
    }
    
    func imageUrl(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
}
