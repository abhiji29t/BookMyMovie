//
//  MovieDetailController.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 26/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

// View controller for detail page
class MovieDetailController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var movieDetailView: UIView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var bookButton: UIButton!

    // To handle expandable details
    struct ExpandableDetail {
        var isExpanded: Bool
        var detailItems: [Any]
    }
    
    weak var bookingDelegate: BookingsDelegate?

    var movieData = MovieData(id: -1, imageURL: "", name: "", date: "")
    var detailData = [ExpandableDetail]()
    let imageCache = NSCache<NSString, UIImage>()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.renderMovieDetails()
        self.initialiseDetailDataArray()
        self.initialiseNibs()

        let movieId = String(movieData.id)
        self.getSynopsis(forMovieID: movieId)
        self.getSimilarMovies(forMovieID: movieId)
        self.getCast(forMovieID: movieId)
        self.getReview(forMovieID: movieId)

        detailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.detailTableView.estimatedRowHeight = 100
        self.detailTableView.rowHeight = UITableView.automaticDimension
    }

    // Registers all the cells required
    private func initialiseNibs() {
        let synopsisNib = UINib(nibName: "SynopsisTableViewCell", bundle: nil)
        self.detailTableView.register(synopsisNib, forCellReuseIdentifier: synopsisReuseIdentifier)

        let similarNib = UINib(nibName: "SimilarTableViewCell", bundle: nil)
        self.detailTableView.register(similarNib, forCellReuseIdentifier: similarReuseIdentifier)

        let castNib = UINib(nibName: "CastTableViewCell", bundle: nil)
        self.detailTableView.register(castNib, forCellReuseIdentifier: castReuseIdentifier)

        let reviewNib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        self.detailTableView.register(reviewNib, forCellReuseIdentifier: reviewReuseIdentifier)
    }

    private func initialiseDetailDataArray() {
        for _ in 0...3 {
            detailData.append(ExpandableDetail(isExpanded: false, detailItems: []))
        }
    }

    // Renders movie details like poster, date and book button on top
    func renderMovieDetails() {
        self.title = self.movieData.name
        self.posterView.layer.cornerRadius = 10
        self.bookButton.layer.cornerRadius = 10

        if let date = Utility.getFormattedDate(forDateString: self.movieData.date) {
            self.releaseDate.text = date
        }
        self.posterView.getImageFromURL(self.movieData.imageURL, withCache: self.imageCache)
        self.movieDetailView.backgroundColor = ultraLightGrayColor
        self.detailTableView.backgroundColor = ultraLightGrayColor
    }

    // Gives Booking request
    @IBAction func bookButtonPressed(_ sender: Any) {
        bookingDelegate?.bookMovieWith(self.movieData)
    }
}
