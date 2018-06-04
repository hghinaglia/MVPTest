//
//  UserListServiceMock.swift
//  MVPTestTests
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

import Foundation
@testable import MVPTest

class UserListServiceSuccessMock: UserDataManager {

    func fetchUsers(onSuccess successHandler: @escaping ([User]) -> (),
                    onFailure failureHandler: @escaping (Error) -> ()) {
        let user1 = User(id: 1, name: "mock user 1", username: nil, email: nil, phone: nil, website: nil, address: nil, company: nil)
        let user2 = User(id: 2, name: "mock user 2", username: nil, email: nil, phone: nil, website: nil, address: nil, company: nil)
        let user3 = User(id: 3, name: "mock user 3", username: nil, email: nil, phone: nil, website: nil, address: nil, company: nil)
        let user4 = User(id: 4, name: "mock user 4", username: nil, email: nil, phone: nil, website: nil, address: nil, company: nil)

        let mockUsers = [user1, user2, user3, user4]
        successHandler(mockUsers)
    }

}

class UserListServiceEmptyMock: UserDataManager {

    func fetchUsers(onSuccess successHandler: @escaping ([User]) -> (),
                    onFailure failureHandler: @escaping (Error) -> ()) {

        successHandler([])
    }

}

class UserListServiceFailureMock: UserDataManager {
    enum MockError: Error {
        case error
    }

    func fetchUsers(onSuccess successHandler: @escaping ([User]) -> (),
                    onFailure failureHandler: @escaping (Error) -> ()) {

        failureHandler(MockError.error)
    }
}

