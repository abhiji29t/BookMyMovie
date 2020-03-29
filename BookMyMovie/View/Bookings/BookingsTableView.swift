//
//  BookinsTableView.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 29/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

extension BookingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingsCollection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bookingCellReuseIdentifier, for: indexPath) as! BookingTableViewCell

        let bookingData = bookingsCollection[indexPath.row]
        cell.setMovieCellValues(bookingData.name, bookingData.imageURL, bookingData.date)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.bookingsCollection.isEmpty {
            return "You have made no bookings yet!"
        }
        return ""
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.bookingsCollection.isEmpty {
            return 50
        }
        return 0
    }
}
