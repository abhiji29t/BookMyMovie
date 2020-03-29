//
//  MovieListViewController.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 25/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

protocol BookingsDelegate: class {
    func bookMovieWith(_ movieData: MovieData)
}

struct MovieData {
    var id: Int
    var imageURL: String
    var name: String
    var date: String
}
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
        defaults.set(searchCacheItems, forKey: searchCacheKey)
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
