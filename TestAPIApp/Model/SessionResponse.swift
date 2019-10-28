//
//  SessionNow.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 18.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import Foundation

struct SessionResponse: Decodable {
    var status: Int
    var error: String?
    var data: DataSession?
}

struct DataSession: Decodable {
    var session: String
}
