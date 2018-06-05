//
//  UserListPresenter.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

protocol UserListPresenterContract: class {
    init(dataManager: UserDataManagerContract)
    func attachView(view: UserListViewContract)
    func detachView()
    func viewIsReady()
    func userDetails(userId: Int)
}

class UserListPresenter: UserListPresenterContract {

    let dataManager: UserDataManagerContract

    private weak var userListView: UserListViewContract?    

    required init(dataManager: UserDataManagerContract) {
        self.dataManager = dataManager
    }

    func attachView(view: UserListViewContract) {
        userListView = view
        userListView?.state = .initial
    }

    func detachView() {
        userListView = nil
    }

    func userDetails(userId id: Int) {
        userListView?.showUserDetails(userId: id)
    }

    func viewIsReady() {
        loadUsers()
    }

    private func loadUsers() {
        userListView?.state = .loading
        dataManager.fetchUsers(onSuccess: { [weak self] (users: [User]) in
            guard let strongSelf = self else { return }
            let userListItems: [UserListModel] = users.map({ UserListModel(id: $0.id, name: $0.name) })
            if userListItems.isEmpty {
                strongSelf.userListView?.state = .empty
            } else {
                strongSelf.userListView?.state = .content(userListItems)
            }
        }, onFailure: { [weak self] (error: Error) in
            guard let strongSelf = self else { return }
            strongSelf.userListView?.state = .error(error)
        })
    }

}
