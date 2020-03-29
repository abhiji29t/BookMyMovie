//
//  Utility.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

class Utility {
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

    static func findSearchResultsForSearchString(_ searchString: String, inMovieNames movieNames: [String]) -> [String] {
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
