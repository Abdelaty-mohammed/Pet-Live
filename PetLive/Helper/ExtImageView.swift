//
//  ExtImageView.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/12/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation
import FirebaseStorage
import UIKit


let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .gray)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    print("done image downloaded")
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
            
        }).resume()
    }
    
    
    
    
    func uploadToFireDB(image: UIImage,
                completion: @escaping (_ urlstring: String?) -> ()) {
        let storageref = Storage.storage().reference().child("images")
        var imgData = image.pngData()
        imgData = image.jpegData(compressionQuality: 0.70)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageref.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil {
                print("success")
                storageref.downloadURL(completion: { (url, error) in
                    completion(url?.absoluteString)
                })
            }else
            {
                print("fail")
                completion(nil)
            }
        }
    }
    
    
    
    
    
}
