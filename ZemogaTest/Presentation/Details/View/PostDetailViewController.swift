//
//  PostDetailViewController.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import UIKit
import Toast_Swift

/// The `PostDetailViewController` class manages and defines all the behavior
/// of all the view hierarchies that represent the detail of the `Post`.
class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    /// The custom `UIButton` that back in the navigation.
    private let backButton = UIButton(type:.custom)
    /// The custom `UIButton` to set as favorite the `Post`.
    private let favoriteButton = UIButton(type:.custom)
    /// The custom `UIButton` that  delete the `Post`.
    private let deleteButton = UIButton(type: .custom)
    /// The `UITableView` manages the basic appearance of the table
    /// providing the cells and behavior from the list of `Comments`.
    @IBOutlet var table: UITableView!
    /// Title label from `Post`.
    @IBOutlet var titleLabel: UILabel!
    /// Content label from `Post`.
    @IBOutlet var contentLabel: UILabel!
    /// Name label from `User`.
    @IBOutlet var nameLabel: UILabel!
    /// Email label from `User`.
    @IBOutlet var emailLabel: UILabel!
    /// Web label from `User`.
    @IBOutlet var websiteLabel: UILabel!
    /// the `Post` to show in detail
    var post:Post? = nil
    /// A `PostDetailViewModel` instance as singleton
    let viewModel = PostDetailViewModel()
    
    // MARK: - Lifecycle
    
    /// A method called after the `UIViewController` has loaded its view hierarchy into the memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /// A method called before the `UIViewController` will be added to the UI hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
        self.showNavBarItems()
        self.fetchData()
    }
    
    /// This method is called in response to a view being removed from a view hierarchy.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideNavBarItems()
    }

    // MARK: - Private methods
    
    /// Method to set up own UI from `PostsViewController`.
    private func setupUI() {
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        self.favoriteButton.setImage(UIImage(named: "navFavorite"), for: .normal)
        self.deleteButton.setImage(UIImage(named: "delete"), for: .normal)
        self.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.favoriteButton.addTarget(self, action: #selector(isFavoriteAction), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        self.setupNavigation(
            title: "Detail",
            leftButton: self.backButton,
            rightButton: self.favoriteButton,
            secondRightButton: self.deleteButton,
            tint: .systemBackground,
            background: .systemGray6
        )
    }
    
    /// Method to show the custom `Navigation Bar Items`.
    private func showNavBarItems() {
        self.backButton.isHidden = false
        self.favoriteButton.isHidden = false
        self.deleteButton.isHidden = false
    }
    
    /// Method to hide the custom `Navigation Bar Items`.
    private func hideNavBarItems() {
        self.backButton.isHidden = true
        self.favoriteButton.isHidden = true
        self.deleteButton.isHidden = true
    }
    
    /// Method to reload the detailed data from the `Post`.
    private func reloadData() {
        
        if let postVM = self.viewModel.otherViewModels["postViewModel"] as? PostViewModel {
            self.titleLabel.text = postVM.title
            self.contentLabel.text = postVM.body
            if postVM.isFavorite {
                self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            }
            else {
                self.favoriteButton.setImage(UIImage(named: "navFavorite"), for: .normal)
            }
        }
        if let userVM = self.viewModel.otherViewModels["userViewModel"] as? UserViewModel {
            self.nameLabel.text = userVM.name
            self.emailLabel.text = userVM.email
            self.websiteLabel.text = userVM.website
        }
        self.table.reloadData()
    }
    
    /// Method to fetch the  detailed data from the `Post`.
    private func fetchData() {
        self.viewModel.loadLocal(post: self.post!)
        if self.viewModel.commentViewModels.count == 0 {
            self.view.makeToastActivity(.center)
            self.viewModel.loadFromNetwork(post: self.post!) {
                self.view.hideToastActivity()
                self.reloadData()
            }
        }
        else {
            self.reloadData()
        }
    }
    
    /// Method to back on `Navigation Bar Controller`.
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Method to set as favorite the `Post`.
    @objc func isFavoriteAction() {
        if let postVM = self.viewModel.otherViewModels["postViewModel"] as? PostViewModel {
            if postVM.isFavorite {
                postVM.updateIsFavorite(value: false)
                self.favoriteButton.setImage(UIImage(named: "navFavorite"), for: .normal)
            }
            else {
                postVM.updateIsFavorite(value: true)
                self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            }
        }
    }
    
    /// Method to delete the `Post`.
    @objc func deleteAction() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            if let postVM = self.viewModel.otherViewModels["postViewModel"] as? PostViewModel {
                postVM.delete()
                self.backAction()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
