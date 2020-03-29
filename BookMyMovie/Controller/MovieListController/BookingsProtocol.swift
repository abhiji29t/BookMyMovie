//
//  BookingsProtocol.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

protocol BookingsDelegate: class {
    func bookMovieWith(_ movieData: MovieData)
}

extension MovieListViewController: BookingsDelegate {
    func bookMovieWith(_ movieData: MovieData) {
        if checkIfMovieAlreadyBooked(movieData) {
            showAlert(for: true, with: movieData)
        } else {
            showAlert(for: false, with: movieData)
            bookingsCollection.append(movieData)
        }
    }

    func showAlert(for isMovieAlreadybooked: Bool, with movieData: MovieData) {
        var title: String, message: String

        if isMovieAlreadybooked {
            title = "Don't be GREEDY \u{1F47F}"
            message = "You already have a free ticket for \n\"" + movieData.name.uppercased() + "\""
        } else {
            title = "CONGRATULATIONS \u{1F91F}"
            message = "You have won a free ticket for \n\"" + movieData.name.uppercased() + "\""
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func checkIfMovieAlreadyBooked(_ movieData: MovieData) -> Bool {
        for item in bookingsCollection {
            if item.id == movieData.id {
                return true
            }
        }
        return false
    }

}

