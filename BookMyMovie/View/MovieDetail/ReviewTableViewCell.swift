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
    @IBOutlet weak var containerView: UIView!

    func setReviewCellValues(_ author: String, _ content: String) {
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        self.containerView.backgroundColor = veryLightGrayColor

        self.authorLabel.text = author == "" ? "UNKNNOWN" : author
        self.contentLabel.text = content
        self.backgroundColor = ultraLightGrayColor
    }
}
