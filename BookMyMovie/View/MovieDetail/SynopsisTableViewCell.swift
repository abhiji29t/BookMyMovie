//
//  SynopsisTableViewCell.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 27/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class SynopsisTableViewCell: UITableViewCell {

    @IBOutlet weak var synopsisLabel: UILabel!

    func setupSynopsisCell(withSynopsis content: String) {
        synopsisLabel.text = content
        self.backgroundColor = ultraLightGrayColor
    }

}
