//
//  ReviewTableViewCell.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 27/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    func setReviewCellValues(_ author: String, _ content: String) {
        self.authorLabel.text = author + " !!!!!!!!!!!!!!!!!!!!!!!"
        self.contentLabel.text = content
    }
}
