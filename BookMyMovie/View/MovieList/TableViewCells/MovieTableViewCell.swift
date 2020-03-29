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
    @IBOutlet weak var containerView: UIView!

    var movieData: MovieData?
    weak var bookingDelegate: BookingsDelegate?
    
    let imageCache = NSCache<NSString, UIImage>()

    func setMovieCellValues(withMovieData movieData: MovieData) {
        self.movieData = movieData

        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        self.posterView.layer.cornerRadius = 10
        self.bookButton.layer.cornerRadius = 10

        self.containerView.backgroundColor = lightGrayColor
        self.backgroundColor = ultraLightGrayColor

        self.movieName.text = movieData.name
        if let date = Utility.getFormattedDate(forDateString: movieData.date) {
            self.releaseDate.text = date
        }
        self.posterView.getImageFromURL(movieData.imageURL, withCache: imageCache)
    }

    @IBAction func bookButtonPressed(_ sender: Any) {
        if let movieData = self.movieData {
            bookingDelegate?.bookMovieWith(movieData)
        }
    }

}
