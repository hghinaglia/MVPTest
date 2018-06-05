//
//  UserListService.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

protocol UserDataManagerContract {

    var users: [User] { get }

    func fetchUsers(onSuccess successHandler: @escaping (_ users: [User]) -> (), onFailure failureHandler: @escaping (_ error: Error) -> ())
    func userDetails(for id: Int) -> User?
}

class UserDataManager: UserDataManagerContract {

    static let shared = UserDataManager()

    private(set) var users: [User] = []

    func fetchUsers(onSuccess successHandler: @escaping (_ users: [User]) -> (),
                    onFailure failureHandler: @escaping (_ error: Error) -> ()) {

        APIManager.shared.loadUsers(onSuccess: { [weak self] (users: [User]) in
            guard let strongSelf = self else { return }
            strongSelf.users = users
            successHandler(users)
        }, onFailure: failureHandler)
    }

    func userDetails(for id: Int) -> User? {
        return users.first(where: { $0.id == id })
    }

}
