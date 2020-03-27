//
//  MovieTableView.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 26/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

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

    private func getMovieListCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.listCellReuseIdentifier, for: indexPath) as! MovieTableViewCell

        let movieData = moviesDataCollection[indexPath.row]
        cell.setMovieCellValues(movieData.name, movieData.imageURL, movieData.date)

        return cell
    }

    private func getSearchCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.searchCellReuseIdentifier, for: indexPath) as! MovieSearchTableViewCell

        let searchData = self.searchMovieCollection[indexPath.row]
        cell.setMovieCellValues(searchData.name)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.isRecentlySearchedItemShowing {
            return "Recently Searced"
        }
        return ""
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailController = storyboard?.instantiateViewController(identifier: "MovieDetailController") as? MovieDetailController {
            var movieId: Int, name: String
            switch self.listMode {
            case .nowShowing:
                movieId = moviesDataCollection[indexPath.row].id
                name = moviesDataCollection[indexPath.row].name
            case .search:
                movieId = searchMovieCollection[indexPath.row].id
                name = searchMovieCollection[indexPath.row].name
            }
            movieDetailController.movieID = String(movieId)
            movieDetailController.title = name

            self.navigationController?.pushViewController(movieDetailController, animated: true)
            if listMode == .search {
                self.addToCacheMoiveID(movieId)
                self.cleanupSearchView()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
