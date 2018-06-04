//
//  UserListPresenter.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

protocol UserListViewContract: class {
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func showUserList(users: [UserListModel])
    func showEmpty()
    func showError(error: Error)
    func showUserDetails(user: User)
}

class UserListPresenter: UserListPresenterContract {

    let service: UserDataManager

    private weak var userListView: UserListViewContract?
    private var users: [User] = []

    required init(service: UserDataManager) {
        self.service = service
    }

    func attachView(view: UserListViewContract) {
        userListView = view
    }

    func detachView() {
        userListView = nil
    }

    func userDetails(userId id: Int) {
        guard let user = users.first(where: { $0.id == id }) else { return }
        userListView?.showUserDetails(user: user)
    }

    func viewIsReady() {
        loadUsers()
    }

    private func loadUsers() {
        userListView?.startLoadingAnimation()
        service.fetchUsers(onSuccess: { [weak self] (users: [User]) in
            guard let strongSelf = self else { return }
            strongSelf.userListView?.stopLoadingAnimation()
            strongSelf.users = users
            let userListItems: [UserListModel] = users.map({ UserListModel(id: $0.id, name: $0.name) })
            if userListItems.isEmpty {
                strongSelf.userListView?.showEmpty()
            } else {
                strongSelf.userListView?.showUserList(users: userListItems)
            }
        }, onFailure: { [weak self] (error: Error) in
            guard let strongSelf = self else { return }
            strongSelf.userListView?.stopLoadingAnimation()
            strongSelf.userListView?.showError(error: error)
        })
    }

}
