//
//  CastTableViewCell.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 27/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var realName: UILabel!

    let imageCache = NSCache<NSString, UIImage>()

    func setCastCellValues(_ characterName: String, _ realName: String, _ posterImageURL: String) {
        self.characterName.text = characterName
        self.realName.text = realName
        self.posterView.getImageFromURL(posterImageURL, withCache: imageCache)
    }
}
