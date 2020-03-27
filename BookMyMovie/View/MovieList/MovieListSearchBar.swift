//
//  MovieListSearchBar.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 27/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            self.getResultsForSearchString(searchString)
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
                self.getResultsForSearchString(searchString)
            }
        }
    }

    private func getResultsForSearchString(_ searchString: String) {
        self.searchMovieCollection = moviesDataCollection.filter({$0.name.localizedCaseInsensitiveContains(searchString)})
        self.isRecentlySearchedItemShowing = false
        self.showSearchItemsInTableView()
    }

    func cleanupSearchView() {
        self.listMode = .nowShowing
        self.hideShowBackToListButton(false)
        self.movieSearchBar.text = ""
        self.movieSearchBar.resignFirstResponder()
        self.isRecentlySearchedItemShowing = false
        self.movieTableView.reloadData()
    }

    private func showSearchItemsInTableView() {
        self.hideShowBackToListButton(true)
        self.listMode = .search
        self.movieTableView.reloadData()
    }

}
