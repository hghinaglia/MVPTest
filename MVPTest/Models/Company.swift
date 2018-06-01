//
//  Company.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

struct Company: Codable {
    var name: String
    var phrase: String?
    var business: String?

    enum CodingKeys: String, CodingKey {
        case name
        case phrase = "catchPhrase"
        case business = "bs"
    }
}
