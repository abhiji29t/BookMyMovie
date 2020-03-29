//
//  BookingTableViewCell.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!

    let imageCache = NSCache<NSString, UIImage>()

    func setMovieCellValues(_ movieName: String, _ posterImageURL: String, _ releaseDate: String) {
        self.posterView.layer.cornerRadius = 10

        self.movieName.text = movieName
        if let date = Utility.getFormattedDate(forDateString: releaseDate) {
            self.releaseDate.text = date
        }
        self.posterView.getImageFromURL(posterImageURL, withCache: imageCache)
    }


}
