//
//  UserListViewController.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

import UIKit

protocol UserListViewContract: class {

    var state: State? { get set }
    var users: [UserListModel] { get set }

    func showUserDetails(userId: Int)
}

class UserListViewController: UIViewController {

    var state: State? {
        didSet {
            update()
        }
    }

    private let presenter: UserListPresenterContract = UserListPresenter(dataManager: UserDataManager.shared)

    weak var tableView: UITableView!
    weak var activityIndicator: UIActivityIndicatorView!
    weak var emptyView: UIView!

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

        let emptyView = UIView()
        emptyView.backgroundColor = .red
        view.addSubview(emptyView)
        self.emptyView = emptyView

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
        emptyView.frame = view.bounds
    }

    private func update() {
        guard let state = state else { return }

        switch state {
        case .initial:
            emptyView.isHidden = true
            tableView.isHidden = true
        case .loading:
            activityIndicator.startAnimating()
            tableView.isHidden = true
            emptyView.isHidden = true
        case .content(let data):
            guard let users = data as? [UserListModel] else { return }
            self.users = users
            tableView.reloadData()
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            emptyView.isHidden = true
        case .empty:
            activityIndicator.stopAnimating()
            tableView.isHidden = true
            emptyView.isHidden = false
        case .error(let error):
            activityIndicator.stopAnimating()
            emptyView.isHidden = true
            tableView.isHidden = true
            let alert = UIAlertController(title: "ERROR", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

}

// MARK: - UserListViewContract
extension UserListViewController: UserListViewContract {

    func showUserDetails(userId: Int) {
        show(UserDetailsViewController(userId: userId), sender: nil)
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

