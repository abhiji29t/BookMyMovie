//
//  SimilarTableViewCell.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 27/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class SimilarTableViewCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieName: UILabel!

    let imageCache = NSCache<NSString, UIImage>()

    func setSimilarCellValues(_ movieName: String, _ posterImageURL: String) {
        self.movieName.text = movieName
        self.posterView.getImageFromURL(posterImageURL, withCache: imageCache)
    }
}
