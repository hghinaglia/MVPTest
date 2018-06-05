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
    lazy var users: [UserListModel] = []

    var state: State? {
        didSet {
            update()
        }
    }
    var userDetailsUserId: Int?

    func showUserDetails(userId: Int) {
        self.userDetailsUserId = userId
    }

    func update() {

        guard let state = state else { return }

        switch state {
        case .content(let data):
            guard let users = data as? [UserListModel] else { return }
            self.users = users
        default:
            return
        }

    }
}
