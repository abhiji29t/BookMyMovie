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

    struct MovieData {
        var id: Int
        var imageURL: String
        var name: String
        var date: String
    }

    enum ListMode {
        case nowShowing
        case search
    }

    let listCellReuseIdentifier = "MovieCell"
    let searchCellReuseIdentifier = "SearchCell"
    let searchCacheKey = "SearchCache"

    var moviesDataCollection = [MovieData]()
    var searchMovieCollection = [MovieData]()
    var listMode: ListMode = .nowShowing

    let defaults = UserDefaults.standard
    var searchCacheItems = [Int]()
    var isRecentlySearchedItemShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideShowBackToListButton(false)
        self.searchCacheItems = defaults.array(forKey: self.searchCacheKey) as? [Int] ?? [Int]()
        self.registerNibs()

        self.movieTableView.estimatedRowHeight = 150
        self.movieTableView.rowHeight = UITableView.automaticDimension

        self.fetchTableViewData()
    }

    private func registerNibs() {
        let movieNib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.movieTableView.register(movieNib, forCellReuseIdentifier: self.listCellReuseIdentifier)

        let searchNib = UINib(nibName: "MovieSearchTableViewCell", bundle: nil)
        self.movieTableView.register(searchNib, forCellReuseIdentifier: self.searchCellReuseIdentifier)
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
        self.cleanupSearchView()
    }

    func hideShowBackToListButton(_ show: Bool) {
        self.backToListButton.tintColor = show ? .link : .clear
        self.backToListButton.isEnabled = show
    }

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
        defaults.set(searchCacheItems, forKey: self.searchCacheKey)
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

    func findSearchResultsForSearchString(_ searchString: String, inMovieNames movieNames: [String]) -> [String] {
        var movideResultArray = [String]()
        var searchWordArray = searchString.lowercased().components(separatedBy: " ")
        searchWordArray = searchWordArray.filter {$0.count > 0}

        MovieDataLoop: for movieName in movieNames {
            let movieNameLC = movieName.lowercased()
            let movieNameWordArray = movieNameLC.components(separatedBy: " ")

            for movieNameWord in movieNameWordArray {
                for searchWord in searchWordArray {
                    let prefix = movieNameWord.prefix(searchWord.count)
                    if prefix == searchWord {
                        movideResultArray.append(movieName)
                        continue MovieDataLoop
                    }
                }
            }
        }
        return movideResultArray
    }
}
