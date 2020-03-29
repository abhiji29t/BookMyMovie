//
//  DataModel.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 25/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

// Model for Now Playing data
struct NowPlaying: Decodable {
    var results: [MovieResult]
}

struct MovieResult: Decodable {
    var id: Int?
    var poster_path: String?
    var title: String?
    var release_date: String?
}


// Model for Synopsis data
struct Overview: Decodable {
    var overview: String?
}


// Model for similar movies data
struct SimilarMovies: Decodable {
    var results: [SimilarMovie]
}

struct SimilarMovie: Decodable {
    var title: String?
    var poster_path: String?
}

// Model for similar credits data
struct Credits: Decodable {
    var cast: [CastData]
}

struct CastData: Decodable {
    var character: String?
    var name: String?
    var profile_path: String?
}


// Model for similar review data
struct Reviews: Decodable {
    var results: [ReviewData]
}

struct ReviewData: Decodable {
    var author: String?
    var content: String?
}
