//
//  UserDetailsViewController.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

import UIKit

protocol UserDetailsViewContract: class {

    var userId: Int { get set }
    func configureView(with user: User)
    func showEmpty()
}

class UserDetailsViewController: UIViewController {

    var userId: Int
    let presenter: UserDetailsPresenterContract = UserDetailsPresenter(dataManager: UserDataManager.shared)

    private weak var textView: UITextView!
    
    init(userId: Int) {
        self.userId = userId

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.isEditable = false
        textView.textColor = .darkGray
        view.addSubview(textView)
        self.textView = textView

        presenter.attachView(view: self)
        presenter.viewIsReady()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = view.bounds
    }

}


// MARK : - UserDetailsViewContract
extension UserDetailsViewController: UserDetailsViewContract {

    func configureView(with user: User) {
        title = user.name

        var details: String = ""
        details += "ID: \(user.id)\n"
        details += "NAME: \(user.name)\n"
        details += "USERNAME: \(user.username!)\n"
        details += "EMAIL: \(user.email!)\n"
        details += "PHONE: \(user.phone!)\n"
        details += "WEBSITE: \(user.website!)\n"
        details += "COMPANY: \(user.company!.name)"
        textView.text = details
    }

    func showEmpty() {
        textView.text = "NO USER DATA AVAILABLE"
    }

}
