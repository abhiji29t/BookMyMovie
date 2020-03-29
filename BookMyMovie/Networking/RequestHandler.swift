//
//  RequestHandler.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 25/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

// Enum to define all types of requests for fetching data from server
enum MovieDetailRequest {
    case nowPlaying
    case synopsis
    case reviews
    case credits
    case similar
}

struct RequestHandler {
    static let shared = RequestHandler()

    private let domain = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "d6841f419a146ff670fc9ff740d9d729"

    // Makes URLRequests for fetching data depending on the request type
    func getURLRequest(forDetail detailType: MovieDetailRequest, forMovieID id: String = "") -> URLRequest? {
        let urlString = domain + self.getRequestString(ofType: detailType, forMovieID: id)
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        return nil
    }

    private func getRequestString(ofType detailType: MovieDetailRequest, forMovieID id: String) -> String {
        switch detailType {
        case .nowPlaying:
            return "now_playing?api_key=" + apiKey
        case .synopsis:
            return id + "?api_key=" + apiKey
        case .reviews:
            return id + "/reviews?api_key=" + apiKey
        case .credits:
            return id + "/credits?api_key=" + apiKey
        case .similar:
            return id + "/similar?api_key=" + apiKey
        }
    }

    // Makes URLRequests for images
    func getImageURLRequest(fromPosterURL posterURL: String) -> URLRequest? {
        let urlString = "https://image.tmdb.org/t/p/w185" + posterURL
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        return nil
    }
}
