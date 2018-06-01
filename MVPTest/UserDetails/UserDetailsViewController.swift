//
//  UserDetailsViewController.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    let user: User

    private weak var textView: UITextView!
    
    init(user: User) {
        self.user = user

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = user.name
        view.backgroundColor = .white

        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.isEditable = false
        textView.textColor = .darkGray
        view.addSubview(textView)
        self.textView = textView

        configureDetails()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = view.bounds
    }

    // MARK: - Helper

    private func configureDetails() {

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

}
