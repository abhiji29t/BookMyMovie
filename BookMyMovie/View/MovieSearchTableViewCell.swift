//
//  MovieSearchTableViewCell.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 27/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var movieLabel: UILabel!

    func setMovieCellValues(_ movieName: String) {
        self.movieLabel.text = movieName
    }
}
