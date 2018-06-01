//
//  UserListViewMock.swift
//  MVPTestTests
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

import Foundation
@testable import MVPTest

class UserListViewMock: UserListViewContract {

    var startLoadingAnimationCalled = false
    var stopLoadingAnimationCalled = false
    var users: [UserListModel] = []
    var error: Error?
    var detailUser: User?

    func startLoadingAnimation() {
        startLoadingAnimationCalled = true
    }

    func stopLoadingAnimation() {
        stopLoadingAnimationCalled = true
    }

    func didFail(error: Error) {
        self.error = error
    }

    func didLoad(users: [UserListModel]) {
        self.users = users
    }

    func showUserDetails(user: User) {
        self.detailUser = user
    }
}
