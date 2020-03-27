//
//  MovieTableViewCell.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 25/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var bookButton: UIButton!

    let imageCache = NSCache<NSString, UIImage>()

    func setMovieCellValues(_ movieName: String, _ posterImageURL: String, _ releaseDate: String) {
        self.movieName.text = movieName
        self.releaseDate.text = releaseDate
        self.posterView.getImageFromURL(posterImageURL, withCache: imageCache)
    }

    @IBAction func bookButtonPressed(_ sender: Any) {
        //Booking Code
    }

}
