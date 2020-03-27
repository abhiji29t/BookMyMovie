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
        return moviesDataCollection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! MovieTableViewCell

        let movieData = moviesDataCollection[indexPath.row]
        cell.setMovieCellValues(movieData.name, movieData.imageURL, movieData.date)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailController = storyboard?.instantiateViewController(identifier: "MovieDetailController") as? MovieDetailController {
            movieDetailController.movieID = String(moviesDataCollection[indexPath.row].id)
            movieDetailController.title = moviesDataCollection[indexPath.row].name

            self.navigationController?.pushViewController(movieDetailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
