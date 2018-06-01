//
//  UserListTests.swift
//  UserListTests
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

import XCTest
@testable import MVPTest

class UserListTests: XCTestCase {

    func testUserListView_whenServiceSucceeds_shouldSetUsers() {
        let viewMock = UserListViewMock()
        let serviceMock = UserListServiceSuccessMock()

        let presenter = UserListPresenter(service: serviceMock)
        presenter.attachView(view: viewMock)
        presenter.loadUsers()

        XCTAssertTrue(viewMock.startLoadingAnimationCalled)
        XCTAssertTrue(viewMock.stopLoadingAnimationCalled)
        XCTAssertFalse(viewMock.users.isEmpty)        
        XCTAssertNil(viewMock.error)
    }

    func testUserListView_whenGettingUserDetails_shouldReturnUserDetails() {
        let viewMock = UserListViewMock()
        let serviceMock = UserListServiceSuccessMock()
        let presenter = UserListPresenter(service: serviceMock)
        presenter.attachView(view: viewMock)
        presenter.loadUsers()

        let user = viewMock.users[0]
        presenter.userDetails(userId: user.id)

        XCTAssertNotNil(viewMock.detailUser)
        XCTAssertTrue(viewMock.detailUser!.id == user.id)
    }

    func testUserListView_whenServiceFails_shouldHandleError() {
        let viewMock = UserListViewMock()
        let serviceMock = UserListServiceFailureMock()
        let presenter = UserListPresenter(service: serviceMock)
        presenter.attachView(view: viewMock)
        presenter.loadUsers()

        XCTAssertTrue(viewMock.startLoadingAnimationCalled)
        XCTAssertTrue(viewMock.stopLoadingAnimationCalled)
        XCTAssertTrue(viewMock.users.isEmpty)
        XCTAssertNotNil(viewMock.error)
    }
    
}
