//
//  MovieListViewController+Caching.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

extension MovieListViewController {
    func addToCacheMoiveID(_ movieId: Int) {
        if searchCacheItems.contains(movieId) {
            if let indexOfItem = searchCacheItems.firstIndex(of: movieId) {
                searchCacheItems.remove(at: indexOfItem)
                searchCacheItems.insert(movieId, at: 0)
            }
        } else {
            if searchCacheItems.count >= 5 {
                searchCacheItems.removeLast()
            }
            searchCacheItems.insert(movieId, at: 0)
        }
        defaults.set(searchCacheItems, forKey: searchCacheKey)
    }

    func getCachedMovieNames() -> [MovieData] {
        var cachedMovieData = [MovieData]()
        for movieID in searchCacheItems {
            let movieData = moviesDataCollection.filter { $0.id == movieID }
            if movieData.count > 0 {
                cachedMovieData.append(movieData[0])
            }
        }
        return cachedMovieData
    }
}
