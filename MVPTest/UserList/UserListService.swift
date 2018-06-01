//
//  UserListService.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

protocol UserDataSource {
    func fetchUsers(onSuccess successHandler: @escaping (_ users: [User]) -> (),
                    onFailure failureHandler: @escaping (_ error: Error) -> ())
}

class UserListService: UserDataSource {

    func fetchUsers(onSuccess successHandler: @escaping (_ users: [User]) -> (),
                    onFailure failureHandler: @escaping (_ error: Error) -> ()) {

        APIManager.shared.loadUsers(onSuccess: successHandler, onFailure: failureHandler)
    }
}
