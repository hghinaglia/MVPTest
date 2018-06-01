//
//  Address.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

struct Address: Codable {
    var street: String?
    var suite: String?
    var city: String
    var zipcode: String
    var location: Location?

    enum CodingKeys: String, CodingKey {
        case street, suite, city, zipcode
        case location = "geo"
    }
}
