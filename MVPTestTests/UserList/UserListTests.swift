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

    func testUserListView_whenViewIsReady_shouldPerformRequestAndCallShowAndStopLoadingAnimation() {
        let viewMock = UserListViewMock()
        let serviceMock = UserListServiceSuccessMock()

        let presenter = UserListPresenter(service: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()

        XCTAssertTrue(viewMock.startLoadingAnimationCalled)
        XCTAssertTrue(viewMock.stopLoadingAnimationCalled)
    }

    func testUserListView_whenServiceSucceeds_shouldSetUsers() {
        let viewMock = UserListViewMock()
        let serviceMock = UserListServiceSuccessMock()

        let presenter = UserListPresenter(service: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()

        XCTAssertFalse(viewMock.users.isEmpty)
    }

    func testUserListView_whenGettingUserDetails_shouldReturnUserDetails() {
        let viewMock = UserListViewMock()
        let serviceMock = UserListServiceSuccessMock()
        let presenter = UserListPresenter(service: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()

        let user = viewMock.users[0]
        presenter.userDetails(userId: user.id)

        XCTAssertNotNil(viewMock.detailUser)
        XCTAssertTrue(viewMock.detailUser!.id == user.id)
    }

    func testUserListView_whenServiceSucceedAndIsEmpty_shouldShowEmptyState() {
        let viewMock = UserListViewMock()
        let serviceMock = UserListServiceEmptyMock()
        let presenter = UserListPresenter(service: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()

        XCTAssertTrue(viewMock.showEmptyCalled)
    }

    func testUserListView_whenServiceFails_shouldHandleError() {
        let viewMock = UserListViewMock()
        let serviceMock = UserListServiceFailureMock()
        let presenter = UserListPresenter(service: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()
     
        XCTAssertNotNil(viewMock.error)
    }
    
}
