//
//  PostsViewController.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import UIKit
import Toast_Swift

/// The `PostsViewController` class manages and defines all the behavior
/// of all the view hierarchies that represent the list of `Posts`.
class PostsViewController: UIViewController, UINavigationControllerDelegate {
    
    /// The custom `UIButton` that refresh the list.
    private let refeshButton = UIButton(type:.custom)
    /// The `UITableView` manages the basic appearance of the table, providing the cells and behavior from the list of `Posts`.
    @IBOutlet var table: UITableView!
    /// A horizontal control that consists of 2 segments, each segment functioning as a discrete button.
    @IBOutlet var segmentedResults: UISegmentedControl!
    /// A `PostsViewModel` instance as singleton
    let viewModel = PostsViewModel()
    
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
        self.fetchPosts()
    }
    
    /// This method is called in response to a view being removed from a view hierarchy.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideNavBarItems()
    }

    // MARK: - Methods
    
    /// Method to set up own UI from `PostsViewController`.
    private func setupUI() {
        self.refeshButton.setImage(UIImage(named: "Refresh"), for: .normal)
        self.refeshButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        self.setupNavigation(
            title: NSLocalizedString("POSTS_TITLE", comment: "Posts"),
            leftButton: nil,
            rightButton: self.refeshButton,
            secondRightButton: nil,
            tint: .systemBackground,
            background: .systemGray6
        )
    }
    
    /// Method to show the custom `Navigation Bar Items`.
    private func showNavBarItems() {
        self.refeshButton.isHidden = false
    }
    
    /// Method to hide the custom `Navigation Bar Items`.
    private func hideNavBarItems() {
        self.refeshButton.isHidden = true
    }
    
    /// Method to fetch the  `Posts`.
    private func fetchPosts() {
        self.viewModel.loadLocal()
        self.table.reloadData()
        if self.viewModel.postViewModels.count == 0 {
            self.refreshAction()
        }
    }
    
    /// Method to fetch the  favorite `Posts`.
    private func fetchFavorites() {
        self.viewModel.loadFavorites()
        self.table.reloadData()
    }
    
    /// Method to refresh the `Posts`.
    @objc func refreshAction() {
        self.view.makeToastActivity(.center)
        self.viewModel.loadFromNetwork {
            self.view.hideToastActivity()
            self.table.reloadData()
        }
    }
    
    // MARK: - IBActions
    
    /// `IBAction` to handle the changed value from the segmented control.
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        switch self.segmentedResults.selectedSegmentIndex {
            case 0:
                self.fetchPosts()
            case 1:
                self.fetchFavorites()
            default:
                break
        }
    }
    
    /// `IBAction` to delete all `Posts`.
    @IBAction func deleteAll() {
        let alert = UIAlertController(title: NSLocalizedString("ALERT_TITLE", comment: "alert"), message: NSLocalizedString("ALERT_MESSAGE", comment: "alert message"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("DELETE", comment: "delete"), style: .destructive, handler: { action in
            self.viewModel.deleteAllPosts()
            self.table.reloadData()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "cancel"), style: .cancel, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
