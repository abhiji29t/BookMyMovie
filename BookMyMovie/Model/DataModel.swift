//
//  DataModel.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 25/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

struct NowPlaying: Decodable {
    var results: [MovieResult]
}

struct MovieResult: Decodable {
    var id: Int?
    var poster_path: String?
    var title: String?
    var release_date: String?
}

struct Overview: Decodable {
    var overview: String?
}

struct SimilarMovies: Decodable {
    var results: [SimilarMovie]
}

struct SimilarMovie: Decodable {
    var title: String?
    var poster_path: String?
}

struct Credits: Decodable {
    var cast: [CastData]
}

struct CastData: Decodable {
    var character: String?
    var name: String?
    var profile_path: String?
}

struct Reviews: Decodable {
    var results: [ReviewData]
}

struct ReviewData: Decodable {
    var author: String?
    var content: String?
}
