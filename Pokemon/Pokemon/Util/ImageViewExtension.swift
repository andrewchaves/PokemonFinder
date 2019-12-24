//
//  ImageViewExtension.swift
//  Peixe Urbano
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit
import Foundation

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  
        contentMode = mode
        
        //Verify need for downloading image.
        if let cacheImage = imageCache.object(forKey: (url.absoluteString) as AnyObject) as? UIImage {
           self.image = cacheImage
           return
        }
        
        //Downloads image if not cached.
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
            else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async() {
                imageCache.setObject(image!, forKey: (url.absoluteString) as AnyObject)
                self.image = image
            }
        }.resume()
        
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
