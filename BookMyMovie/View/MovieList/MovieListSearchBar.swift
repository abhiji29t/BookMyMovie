//
//  MovieListSearchBar.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 27/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

// Handle all search related delegates and operations 
extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            self.populateTableViewForSearchString(searchString)
        }
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchMovieCollection = self.getCachedMovieNames()
        self.isRecentlySearchedItemShowing = true
        self.showSearchItemsInTableView()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchString = searchBar.text {
            if searchString == "" {
                self.searchMovieCollection = self.getCachedMovieNames()
                self.isRecentlySearchedItemShowing = true
                self.showSearchItemsInTableView()
            } else {
                self.populateTableViewForSearchString(searchString)
            }
        }
    }

    // Gets result of movies from search result using algorithm to check for prefixes
    private func populateTableViewForSearchString(_ searchString: String) {
        let movieNames = self.moviesDataCollection.map {$0.name}
        let resultMovieNames = Utility.findSearchResultsForSearchString(searchString, inMovieNames: movieNames)
        self.searchMovieCollection = self.moviesDataCollection.filter { resultMovieNames.contains($0.name)}
        self.isRecentlySearchedItemShowing = false
        self.showSearchItemsInTableView()
    }

    // Cleans up search view before switching to now showing mode
    func cleanupSearchView() {
        self.listMode = .nowShowing
        self.hideShowBackToListButton(false)
        self.movieSearchBar.text = ""
        self.movieSearchBar.resignFirstResponder()
        self.isRecentlySearchedItemShowing = false
        self.movieTableView.reloadData()
    }

    // Switches to search mode and reloads the table view
    private func showSearchItemsInTableView() {
        self.hideShowBackToListButton(true)
        self.listMode = .search
        self.movieTableView.reloadData()
    }

}
