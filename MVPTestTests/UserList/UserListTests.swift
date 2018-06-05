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
        let serviceMock = UserDataManagerSuccessMock()

        let presenter = UserListPresenter(dataManager: serviceMock)
        presenter.attachView(view: viewMock)

        if case State.initial = viewMock.state! {
            XCTAssert(true)
        } else {
            XCTFail("Wrong state")
        }

        presenter.viewIsReady()

//        XCTAssertTrue(viewMock.startLoadingAnimationCalled)
//        XCTAssertTrue(viewMock.stopLoadingAnimationCalled)
    }

    func testUserListView_whenServiceSucceeds_shouldSetUsers() {
        let viewMock = UserListViewMock()
        let serviceMock = UserDataManagerSuccessMock()

        let presenter = UserListPresenter(dataManager: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()

        if case State.content = viewMock.state! {
            XCTAssert(true)
        } else {
            XCTFail("Wrong state")
        }

        XCTAssertFalse(viewMock.users.isEmpty)
    }

    func testUserListView_whenGettingUserDetails_shouldReturnUserDetails() {
        let viewMock = UserListViewMock()
        let serviceMock = UserDataManagerSuccessMock()
        let presenter = UserListPresenter(dataManager: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()
        let user = viewMock.users[0]
        
        presenter.userDetails(userId: user.id)

        XCTAssertNotNil(viewMock.userDetailsUserId)
        XCTAssert(viewMock.userDetailsUserId! == user.id)
    }

    func testUserListView_whenServiceSucceedAndIsEmpty_shouldShowEmptyState() {
        let viewMock = UserListViewMock()
        let serviceMock = UserDataManagerEmptyMock()
        let presenter = UserListPresenter(dataManager: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()

        if case State.empty = viewMock.state! {
            XCTAssert(true)
        } else {
            XCTFail("Wrong state")
        }

        XCTAssert(viewMock.users.isEmpty)
    }

    func testUserListView_whenServiceFails_shouldHandleError() {
        let viewMock = UserListViewMock()
        let serviceMock = UserDataManagerFailureMock()
        let presenter = UserListPresenter(dataManager: serviceMock)
        presenter.attachView(view: viewMock)

        presenter.viewIsReady()

        if case State.error = viewMock.state! {
            XCTAssert(true)
        } else {
            XCTFail("Wrong state")
        }        
    }
    
}
