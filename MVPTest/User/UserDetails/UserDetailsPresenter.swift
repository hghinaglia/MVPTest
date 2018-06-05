//
//  UserDetailsPresenter.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 6/4/18.
//  Copyright © 2018 HG. All rights reserved.
//

import Foundation

protocol UserDetailsPresenterContract: class {
    init(dataManager: UserDataManagerContract)
    func attachView(view: UserDetailsViewContract)
    func detachView()
    func viewIsReady()
}

class UserDetailsPresenter: UserDetailsPresenterContract {

    let dataManager: UserDataManagerContract

    private weak var userDetailsView: UserDetailsViewContract?

    required init(dataManager: UserDataManagerContract) {
        self.dataManager = dataManager
    }

    func attachView(view: UserDetailsViewContract) {
        userDetailsView = view
    }

    func detachView() {
        userDetailsView = nil
    }

    func viewIsReady() {
        if let userId = userDetailsView?.userId, let user = dataManager.userDetails(for: userId) {
            userDetailsView?.configureView(with: user)
        } else {
            userDetailsView?.showEmpty()
        }
    }

}
