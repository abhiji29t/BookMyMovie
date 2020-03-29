//
//  ParsedModel.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

struct MovieData {
    var id: Int
    var imageURL: String
    var name: String
    var date: String
}

struct ExpandableDetail {
    var isExpanded: Bool
    var detailItems: [Any]
}

struct Similar {
    var movieName: String
    var posterURL: String
}

struct Cast {
    var characterName: String
    var realName: String
    var imageURL: String
}

struct Review {
    var author: String
    var reviewContent: String
}
