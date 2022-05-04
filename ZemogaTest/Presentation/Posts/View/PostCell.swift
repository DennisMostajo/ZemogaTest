//
//  PostCell.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 4/30/22.
//

import UIKit

///View of the cell to represent a `Post`.
class PostCell: UITableViewCell {
    /// Icon image to represent details and/or preferences from `Post`.
    @IBOutlet weak var iconImage: UIImageView!
    /// Title label from `Post`.
    @IBOutlet weak var titleLabel: UILabel!
    /// Image to represent navigation to detail view
    @IBOutlet weak var accessoryImage: UIImageView!
    
    /// Method to fill the UI.
    ///
    /// - Parameters:
    ///   - viewModel: The `PostViewModel`.
    func fill(viewModel: PostViewModel) {
        if viewModel.isFavorite {
            self.iconImage.image = UIImage(named: "favorite")
        }
        else {
            self.iconImage.image = nil
        }
        self.titleLabel.text = viewModel.title
        self.accessoryImage.image = UIImage(named: "Arrow")
    }
}
