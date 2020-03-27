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

    private func getResultsForSearchString(_ searchString: String) {
        let filterMovieList = moviesDataCollection.filter({$0.name.localizedCaseInsensitiveContains(searchString)})
        print(filterMovieList)
    }
}
