//
//  ImageView+Downloader.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 27/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImageFromURL(_ url: String, withCache imageCache: NSCache<NSString, UIImage>) {
        self.image = nil

        if let imageFromCache = imageCache.object(forKey: url as NSString) {
            self.image = imageFromCache
            return
        }
        self.downloadImageFromURL(url, withCache: imageCache)
    }

    func downloadImageFromURL(_ url: String, withCache imageCache: NSCache<NSString, UIImage>) {
        let urlRequest = RequestHandler.shared.getImageURLRequest(fromPosterURL: url)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, false) { (result: Result<Data, NetworkError>) in
                switch result {
                case .success(let result):
                    let image = UIImage(data: result)
                    if let imageToCache = image {
                        imageCache.setObject(imageToCache, forKey: url as NSString)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
