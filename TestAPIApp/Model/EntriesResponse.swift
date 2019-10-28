//
//  EntriesResponse.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 18.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import Foundation

struct EntriesResponse: Decodable {
    var status: Int
    var data:[[DataEntries]]?
    var error: String?
}
struct DataEntries: Decodable {
    var id: String
    var body: String
    var da: String
    var dm: String
}
