//
//  Utility.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

class Utility {

    // Converts date from type "2020-02-15" to more readable "15 Feb 2020"
    static func getFormattedDate(forDateString dateString: String) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let date = dateFormatterGet.date(from: dateString)

        if let safeDate = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "en_UK")
            return dateFormatter.string(from: safeDate)
        }
        return nil
    }

    // Finds search results by finding movie names whose any word has the search string as its prefix
    static func findSearchResultsForSearchString(_ searchString: String, inMovieNames movieNames: [String]) -> [String] {
        var movideResultArray = [String]()
        var searchWordArray = searchString.lowercased().components(separatedBy: " ")    // Getting all words of search string in an array
        searchWordArray = searchWordArray.filter {$0.count > 0}      // Filtering empty strings came dude to extra spaces in search string

        MovieDataLoop: for movieName in movieNames {
            let movieNameLC = movieName.lowercased()
            let movieNameWordArray = movieNameLC.components(separatedBy: " ")     // Getting all words of movie name in an array

            for movieNameWord in movieNameWordArray {                             // Iterating through all movie name words
                for searchWord in searchWordArray {
                    let prefix = movieNameWord.prefix(searchWord.count)
                    if prefix == searchWord {                            // Checking if any search word is prefix of any movie name word
                        movideResultArray.append(movieName)
                        continue MovieDataLoop                      //Returning most outer loop using LABEL, if any prefix is matched
                    }
                }
            }
        }
        return movideResultArray
    }
}
