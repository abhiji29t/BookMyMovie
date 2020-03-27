//
//  MovieDetailController.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 26/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {

    struct ExpandableDetail {
        var isExpanded: Bool
        var detailItems: [Any]
    }

    struct Similar {
        var movieName: String
        var posterURL: String
    }

    struct Cast {
        var characterName: String
        var realName: String
        var imageURL: String
    }
    
    struct Review {
        var author: String
        var reviewContent: String
    }

    let synopsisReuseIdentifier = "SynopsisCell"
    let similarReuseIdentifier = "SimilarCell"
    let castReuseIdentifier = "CastCell"
    let reviewReuseIdentifier = "ReviewCell"


    var detailData = [ExpandableDetail]()

    @IBOutlet weak var detailTableView: UITableView!

    var movieID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieId = self.movieID else {
            return
        }
        self.initialiseDetailDataArray()
        self.initialiseNibs()

        self.getSynopsis(forMovieID: movieId)
        self.getSimilarMovies(forMovieID: movieId)
        self.getCast(forMovieID: movieId)
        self.getReview(forMovieID: movieId)

        detailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.detailTableView.estimatedRowHeight = 100
        self.detailTableView.rowHeight = UITableView.automaticDimension
    }

    private func initialiseNibs() {
        let synopsisNib = UINib(nibName: "SynopsisTableViewCell", bundle: nil)
        self.detailTableView.register(synopsisNib, forCellReuseIdentifier: self.synopsisReuseIdentifier)

        let similarNib = UINib(nibName: "SimilarTableViewCell", bundle: nil)
        self.detailTableView.register(similarNib, forCellReuseIdentifier: self.similarReuseIdentifier)

        let castNib = UINib(nibName: "CastTableViewCell", bundle: nil)
        self.detailTableView.register(castNib, forCellReuseIdentifier: self.castReuseIdentifier)

        let reviewNib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        self.detailTableView.register(reviewNib, forCellReuseIdentifier: self.reviewReuseIdentifier)
    }

    private func initialiseDetailDataArray() {
        for _ in 0...3 {
            detailData.append(ExpandableDetail(isExpanded: false, detailItems: []))
        }
    }

    private func getSynopsis(forMovieID movieId: String) {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .synopsis, forMovieID: movieId)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { (result: Result<Overview, NetworkError>) in
                switch result {
                case .success(let results):
                    self.setUpSynopsisData(withResult: results)
                    DispatchQueue.main.async {
                        self.detailTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func setUpSynopsisData(withResult result: Overview) {
        if let synopsis = result.overview {
            detailData[0].detailItems.append(synopsis)
        }
    }

    private func getSimilarMovies(forMovieID movieId: String) {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .similar, forMovieID: movieId)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { (result: Result<SimilarMovies, NetworkError>) in
                switch result {
                case .success(let results):
                    self.setUpSimilarData(withResult: results)
                    DispatchQueue.main.async {
                        self.detailTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func setUpSimilarData(withResult result: SimilarMovies) {
        if result.results.count > 0 {
            for similarMovie in result.results {
                if let movieName = similarMovie.title, let posterURL = similarMovie.poster_path {
                    detailData[1].detailItems.append(Similar(movieName: movieName, posterURL: posterURL))
                }
            }
        }
    }

    private func getCast(forMovieID movieId: String) {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .credits, forMovieID: movieId)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { (result: Result<Credits, NetworkError>) in
                switch result {
                case .success(let results):
                    self.setUpCastData(withResult: results)
                    DispatchQueue.main.async {
                        self.detailTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func setUpCastData(withResult result: Credits) {
        if result.cast.count > 0 {
            for cast in result.cast {
                if let characterName = cast.character, let artistName = cast.name, let posterURL = cast.profile_path {
                    detailData[2].detailItems.append(Cast(characterName: characterName, realName: artistName, imageURL: posterURL))
                }
            }
        }
    }

    private func getReview(forMovieID movieId: String) {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .reviews, forMovieID: movieId)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { (result: Result<Reviews, NetworkError>) in
                switch result {
                case .success(let results):
                    self.setUpReviewData(withResult: results)
                    DispatchQueue.main.async {
                        self.detailTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func setUpReviewData(withResult result: Reviews) {
        if result.results.count > 0 {
            for review in result.results {
                if let author = review.author, let content = review.content {
                    detailData[3].detailItems.append(Review(author: author, reviewContent: content))
                }
            }
        }
    }
}
