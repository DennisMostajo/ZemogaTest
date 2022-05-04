//
//  CommentCell.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import UIKit

///View of the cell to represent a `Comment`.
class CommentCell: UITableViewCell {
    /// Body label from `Comment`.
    @IBOutlet weak var bodyLabel: UILabel!
    /// Name label from `User`.
    @IBOutlet weak var nameLabel: UILabel!
    /// Email label from `User`.
    @IBOutlet weak var emailLabel: UILabel!

    /// Method to fill the UI.
    ///
    /// - Parameters:
    ///   - viewModel: The `CommentViewModel`.
    func fill(viewModel: CommentViewModel) {
        self.bodyLabel.text = viewModel.body
        self.nameLabel.text = viewModel.name
        self.emailLabel.text = viewModel.email
    }
}
