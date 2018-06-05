//
//  State.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 6/4/18.
//  Copyright © 2018 HG. All rights reserved.
//

enum State {
    case initial
    case loading
    case content(Any)
    case empty
    case error(Error)
}


