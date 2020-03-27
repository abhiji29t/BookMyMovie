//
//  MovieListViewController.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 25/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var backToListButton: UIBarButtonItem!

    struct MovieData {
        var id: Int
        var imageURL: String
        var name: String
        var date: String
    }

    let cellReuseIdentifier = "MovieCell"
    var moviesDataCollection = [MovieData]()
    var isSearchGoingOn = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.movieTableView.register(nib, forCellReuseIdentifier: self.cellReuseIdentifier)

        self.movieTableView.estimatedRowHeight = 150
        self.movieTableView.rowHeight = UITableView.automaticDimension

        self.fetchTableViewData()
    }

    private func fetchTableViewData() {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .nowPlaying)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { (result: Result<NowPlaying, NetworkError>) in
                switch result {
                case .success(let results):
                    self.setUpMovieData(withResult: results)
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func setUpMovieData(withResult result: NowPlaying) {
        if result.results.count > 0 {
            for movieResult in result.results {
                if let id = movieResult.id, let imageURL = movieResult.poster_path, let name = movieResult.title, let date = movieResult.release_date {
                    moviesDataCollection.append(MovieData(id: id, imageURL: imageURL, name: name, date: date))
                }
            }
        }
    }

    @IBAction func backToListButtonPressed(_ sender: UIBarButtonItem) {
        self.backToListButton.tintColor = .clear
        self.backToListButton.isEnabled = false
    }

    func hideShowBackToListButton(_ show: Bool) {
        self.backToListButton.tintColor = .clear
        self.backToListButton.isEnabled = false
    }

}
