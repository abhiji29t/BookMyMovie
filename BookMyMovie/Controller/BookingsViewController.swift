//
//  BookingsViewController.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

class BookingsViewController: UIViewController {

    @IBOutlet weak var bookingsTableView: UITableView!
    var bookingsCollection = [MovieData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.bookingsTableView.reloadData()

    }

    private func registerNib() {
        let bookingNib = UINib(nibName: "BookingTableViewCell", bundle: nil)
        self.bookingsTableView.register(bookingNib, forCellReuseIdentifier: bookingCellReuseIdentifier)
    }
}
