//
//  Posts+Table+Extensions.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import UIKit

/// Custom `Extension` from `PostsViewController` to manage the `UITableView` behavior.
extension PostsViewController:UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView
    
    /// `Delegate` method from `UITableView`.
    /// - Returns:The height of rows.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    /// `Data Source` method from `UITableView`.
    /// - Returns:The number of sections.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// `Data Source` method from `UITableView`.
    /// - Returns:The number of rows.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.postViewModels.count
    }
    
    /// `Data Source` method from `UITableView`.
    /// - Returns:The customized `PostCell`.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        cell.fill(viewModel: self.viewModel.postViewModels[indexPath.row])
        return cell
    }
    
    /// `Delegate` method from `UITableView` when user selected a row.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
        vc.post = self.viewModel.posts?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// `Data Source` method for enable edition on `UITableView`.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// `Data Source` method for  edition behavior on `UITableView`.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let alert = UIAlertController(title: NSLocalizedString("ALERT_TITLE", comment: "alert"), message: NSLocalizedString("ALERT_MESSAGE", comment: "alert message"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("DELETE", comment: "delete"), style: .destructive, handler: { action in
                self.viewModel.postViewModels[indexPath.row].delete()
                self.viewModel.postViewModels.remove(at: indexPath.row)
                self.table.deleteRows(at: [indexPath], with: .automatic)
                self.table.endUpdates()
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "cancel"), style: .cancel, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

