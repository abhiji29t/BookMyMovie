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
    @IBOutlet weak var movieSearchBar: UISearchBar!

    enum ListMode {
        case nowShowing
        case search
    }

    var moviesDataCollection = [MovieData]()
    var searchMovieCollection = [MovieData]()
    var bookingsCollection = [MovieData]()
    var listMode: ListMode = .nowShowing

    let defaults = UserDefaults.standard
    var searchCacheItems = [Int]()
    var isRecentlySearchedItemShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideShowBackToListButton(false)
        self.searchCacheItems = defaults.array(forKey: searchCacheKey) as? [Int] ?? [Int]()
        self.registerNibs()

        self.movieTableView.estimatedRowHeight = 150
        self.movieTableView.rowHeight = UITableView.automaticDimension

        self.fetchTableViewData()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .black
        self.movieSearchBar.barTintColor = ultraLightGrayColor
        self.movieTableView.backgroundColor = ultraLightGrayColor
    }

    private func registerNibs() {
        let movieNib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.movieTableView.register(movieNib, forCellReuseIdentifier: listCellReuseIdentifier)

        let searchNib = UINib(nibName: "MovieSearchTableViewCell", bundle: nil)
        self.movieTableView.register(searchNib, forCellReuseIdentifier: searchCellReuseIdentifier)
    }

    private func fetchTableViewData() {
        let urlRequest = RequestHandler.shared.getURLRequest(forDetail: .nowPlaying)
        if let urlRequest = urlRequest {
            NetworkService.shared.makeUrlRequest(urlRequest, true) { [weak self] (result: Result<NowPlaying, NetworkError>) in
                switch result {
                case .success(let results):
                    self?.setUpMovieData(withResult: results)
                    DispatchQueue.main.async {
                        self?.movieTableView.reloadData()
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
        self.cleanupSearchView()
    }

    @IBAction func bookingsButtonPressed(_ sender: Any) {
        if let bookingsController = storyboard?.instantiateViewController(identifier: "BookingsViewController") as? BookingsViewController {
            bookingsController.bookingsCollection = self.bookingsCollection
            self.navigationController?.pushViewController(bookingsController, animated: true)
        }
    }

    func hideShowBackToListButton(_ show: Bool) {
        self.backToListButton.tintColor = show ? .black : .clear
        self.backToListButton.isEnabled = show
    }
}

