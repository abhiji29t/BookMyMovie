//
//  BookMyMovieTests.swift
//  BookMyMovieTests
//
//  Created by Abhijitkumar A on 28/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import XCTest
@testable import BookMyMovie

class BookMyMovieTests: XCTestCase {

    var movieListViewController: MovieListViewController!
    var movieNames = ["Aquaman", "Spider-Man: Into the Spider-Verse", "KGF", "Ralph Breaks The Internet", "The Grinch", "Bohemian Rhapsody", "Maari", "Dilwale Dulhania Le Jaayenge"]

    override func setUpWithError() throws {
        movieListViewController = MovieListViewController()
    }

    override func tearDownWithError() throws {
        movieListViewController = nil
    }

    // Testing Case 1 of assignment
    func testSearchAlgorithmCase1() {
        let searchString = "r"
        let searchResult = ["Ralph Breaks The Internet", "Bohemian Rhapsody"]

        let resultFromAlgorithm = Utility.findSearchResultsForSearchString(searchString, inMovieNames: movieNames)

        XCTAssertEqual(searchResult, resultFromAlgorithm)
    }

    // Testing Case 2 of assignment
    func testSearchAlgorithmCase2() {
        let searchString = "Le Jaayenge Dilwale"
        let searchResult = ["Dilwale Dulhania Le Jaayenge"]

        let resultFromAlgorithm = Utility.findSearchResultsForSearchString(searchString, inMovieNames: movieNames)

        XCTAssertEqual(searchResult, resultFromAlgorithm)
    }


}
