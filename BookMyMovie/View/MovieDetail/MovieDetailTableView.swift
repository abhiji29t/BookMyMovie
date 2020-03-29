//
//  MovieDetailTableView.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 26/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import UIKit

// Movie Detail table view
extension MovieDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailData.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if detailData[section].isExpanded {
            return detailData[section].detailItems.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = setUpTableViewCell(tableView, forIndexPath: indexPath)
        return cell
    }

    // Calls appropriate method to create the cell for table view
    private func setUpTableViewCell(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell{
        switch indexPath.section {
        case 0:
            return createSynopsisCell(tableView, forIndexPath: indexPath)
        case 1:
            return createSimilarCell(tableView, forIndexPath: indexPath)
        case 2:
            return createCastCell(tableView, forIndexPath: indexPath)
        case 3 :
            return createReviewCell(tableView, forIndexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }

    // Creates cell for synopsis
    private func createSynopsisCell(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: synopsisReuseIdentifier, for: indexPath) as! SynopsisTableViewCell

        let synopsisContent = detailData[0].detailItems[indexPath.row] as? String
        if let content = synopsisContent {
            cell.setupSynopsisCell(withSynopsis: content)
        }
        return cell
    }

    // Creates cell for similar movies
    private func createSimilarCell(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: similarReuseIdentifier, for: indexPath) as! SimilarTableViewCell

        let similarData = detailData[1].detailItems[indexPath.row] as? Similar
        if let similar = similarData {
            cell.setSimilarCellValues(similar.movieName, similar.posterURL)
        }
        return cell
    }

    // Creates cell for cast
    private func createCastCell(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: castReuseIdentifier, for: indexPath) as! CastTableViewCell

        let castData = detailData[2].detailItems[indexPath.row] as? Cast
        if let cast = castData {
            cell.setCastCellValues(cast.characterName, cast.realName, cast.imageURL)
        }
        return cell
    }

    // Creates cell for reviews
    private func createReviewCell(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reviewReuseIdentifier, for: indexPath) as! ReviewTableViewCell

        let reviewData = detailData[3].detailItems[indexPath.row] as? Review
        if let review = reviewData {
            cell.setReviewCellValues(review.author, review.reviewContent)
        }
        return cell
    }

    // Creates header for the section of all details
    // Takes care of the case where no reviews are there
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerButton = UIButton(type: .system)
        let title = self.getHeaderName(forSection: section)
        headerButton.setTitle(title, for: .normal)
        headerButton.setTitleColor(.black, for: .normal)
        headerButton.backgroundColor = lightGrayColor
        headerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        headerButton.tag = section
        if title != "No review in for this movie" {
            headerButton.setImage(.add, for: .normal)
            headerButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        }
        return headerButton
    }

    // Returns appropriate header name for section
    private func getHeaderName(forSection section: Int) -> String {
        switch section {
        case 0:
            return "Synopsis"
        case 1:
            return "Similar Movies"
        case 2:
            return "Cast"
        case 3:
            if detailData[3].detailItems.count == 0 {
                return "No review in for this movie"
            }
            return "Reviews"
        default:
            return ""
        }
    }

    // Handles expansion and collapse of the section
    @objc func handleExpandClose(button: UIButton) {
        var indexPaths = [IndexPath]()
        for row in detailData[button.tag].detailItems.indices {
            indexPaths.append(IndexPath(row: row, section: button.tag))
        }
        detailData[button.tag].isExpanded = !detailData[button.tag].isExpanded
        if !detailData[button.tag].isExpanded {
            self.detailTableView.deleteRows(at: indexPaths, with: .top)
            button.setImage(.add, for: .normal)
        } else {
            self.detailTableView.insertRows(at: indexPaths, with: .top)
            button.setImage(.remove, for: .normal)
        }
    }
}
