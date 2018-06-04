//
//  UserListViewController.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

import UIKit

protocol UserListPresenterContract: class {    
    init(service: UserDataManager)
    func attachView(view: UserListViewContract)
    func detachView()
    func viewIsReady()
    func userDetails(userId: Int)
}

class UserListViewController: UIViewController {

    private let presenter: UserListPresenterContract = UserListPresenter(service: UserListService())    

    weak var tableView: UITableView!
    weak var activityIndicator: UIActivityIndicatorView!

    lazy var users: [UserListModel] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9702569797, green: 0.9702569797, blue: 0.9702569797, alpha: 1)
        title = "Users"

        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
        self.tableView = tableView
        view.addSubview(tableView)

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator

        presenter.attachView(view: self)
        presenter.viewIsReady()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

// MARK: - UserListViewContract
extension UserListViewController: UserListViewContract {

    func startLoadingAnimation() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }

    func stopLoadingAnimation() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }

    func showUserList(users: [UserListModel]) {
        self.users = users
        tableView.reloadData()
    }

    func showEmpty() {
        // TOD: Show empty view
    }

    func showError(error: Error) {
        let alert = UIAlertController(title: "ERROR", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showUserDetails(user: User) {
        show(UserDetailsViewController(user: user), sender: nil)
    }

}


// MARK: - UITableViewDataSource
extension UserListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = user.name
        return cell
    }

}

// MARK: - UITableViewDelegate
extension UserListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        presenter.userDetails(userId: user.id)
    }

}

