//
//  UIImage+Request.swift
//  MyProductHunter
//
//  Created by Fernando on 9/22/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageFromUrlString(urlString: String) {
        let url = URL(string: urlString)!
        imageUrlString = urlString
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
                return
            }
            
            guard let imageData = data else {return}
            
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: imageData) else {return}
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                
            }
        }.resume()
    }
}
