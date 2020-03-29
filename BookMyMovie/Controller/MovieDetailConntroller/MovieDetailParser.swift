//
//  MovieDetailDataParser.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

// Handles requesting movie details from Network Service and then parsing them accroding to detail type
// Handles parsing of synopsis, similar movies, cast and reviews

extension MovieDetailController {
    func getSynopsis(forMovieID movieId: String) {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .synopsis, forMovieID: movieId)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { [weak self] (result: Result<Overview, NetworkError>) in
                switch result {
                case .success(let results):
                    self?.setUpSynopsisData(withResult: results)
                    DispatchQueue.main.async {
                        self?.detailTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func setUpSynopsisData(withResult result: Overview) {
        if let synopsis = result.overview {
            detailData[0].detailItems.append(synopsis)
        }
    }

    func getSimilarMovies(forMovieID movieId: String) {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .similar, forMovieID: movieId)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { [weak self] (result: Result<SimilarMovies, NetworkError>) in
                switch result {
                case .success(let results):
                    self?.setUpSimilarData(withResult: results)
                    DispatchQueue.main.async {
                        self?.detailTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func setUpSimilarData(withResult result: SimilarMovies) {
        if result.results.count > 0 {
            for similarMovie in result.results {
                if let movieName = similarMovie.title, let posterURL = similarMovie.poster_path {
                    detailData[1].detailItems.append(Similar(movieName: movieName, posterURL: posterURL))
                }
            }
        }
    }

    func getCast(forMovieID movieId: String) {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .credits, forMovieID: movieId)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { [weak self] (result: Result<Credits, NetworkError>) in
                switch result {
                case .success(let results):
                    self?.setUpCastData(withResult: results)
                    DispatchQueue.main.async {
                        self?.detailTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func setUpCastData(withResult result: Credits) {
        if result.cast.count > 0 {
            for cast in result.cast {
                if let characterName = cast.character, let artistName = cast.name, let posterURL = cast.profile_path {
                    detailData[2].detailItems.append(Cast(characterName: characterName, realName: artistName, imageURL: posterURL))
                }
            }
        }
    }

    func getReview(forMovieID movieId: String) {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .reviews, forMovieID: movieId)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { [weak self] (result: Result<Reviews, NetworkError>) in
                switch result {
                case .success(let results):
                    self?.setUpReviewData(withResult: results)
                    DispatchQueue.main.async {
                        self?.detailTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func setUpReviewData(withResult result: Reviews) {
        if result.results.count > 0 {
            for review in result.results {
                if let author = review.author, let content = review.content {
                    detailData[3].detailItems.append(Review(author: author, reviewContent: content))
                }
            }
        }
    }
}
