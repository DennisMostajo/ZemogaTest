//
//  PostDetail+Table+Extensions.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

/// Custom `Extension` from `PostDetailViewController` to manage the `UITableView` behavior.
extension PostDetailViewController {

    // MARK: - UITableView
    
    /// `Data Source` method from `UITableView`.
    /// - Returns:The title of section.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    
    /// `Delegate` method from `UITableView`.
    /// - Returns:The height of rows.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    /// `Data Source` method from `UITableView`.
    /// - Returns:The number of sections.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// `Data Source` method from `UITableView`.
    /// - Returns:The number of rows.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.commentViewModels.count
    }
    
    /// `Data Source` method from `UITableView`.
    /// - Returns:The customized `CommentCell`.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        cell.fill(viewModel: self.viewModel.commentViewModels[indexPath.row])
        return cell
    }
}
