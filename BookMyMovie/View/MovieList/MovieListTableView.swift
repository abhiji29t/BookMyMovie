//
//  MovieTableView.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 26/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

// Now Showing table view
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.listMode {
        case .nowShowing:
            return moviesDataCollection.count
        case .search:
            return searchMovieCollection.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch listMode {
        case .nowShowing:
            return getMovieListCell(tableView, cellForRowAt: indexPath)
        case .search:
            return getSearchCell(tableView, cellForRowAt: indexPath)
        }
    }

    // Gets Movie table cells of now showing movies
    private func getMovieListCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellReuseIdentifier, for: indexPath) as! MovieTableViewCell

        let movieData = moviesDataCollection[indexPath.row]
        cell.setMovieCellValues(withMovieData: movieData)
        cell.bookingDelegate = self

        return cell
    }

    // Gets search cell of movies searched
    private func getSearchCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchCellReuseIdentifier, for: indexPath) as! MovieSearchTableViewCell

        let searchData = self.searchMovieCollection[indexPath.row]
        cell.setMovieCellValues(searchData.name)

        return cell
    }

    // Sets header title in case of recently searched movies are showing up
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.isRecentlySearchedItemShowing && !self.searchCacheItems.isEmpty {
            return "Recently Searced"
        }
        return ""
    }

    // Sets header height in case of recently searched movies are showing up
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.isRecentlySearchedItemShowing && !self.searchCacheItems.isEmpty {
            return 50
        }
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailController = storyboard?.instantiateViewController(identifier: "MovieDetailController") as? MovieDetailController {
            var movieData: MovieData
            switch self.listMode {
            case .nowShowing:
                movieData = moviesDataCollection[indexPath.row]
            case .search:
                movieData = searchMovieCollection[indexPath.row]
            }
            movieDetailController.movieData = movieData
            movieDetailController.bookingDelegate = self

            self.navigationController?.pushViewController(movieDetailController, animated: true)
            if listMode == .search {
                self.addToCacheMoiveID(movieData.id)                // Requests adding movie to the cache
                self.cleanupSearchView()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
