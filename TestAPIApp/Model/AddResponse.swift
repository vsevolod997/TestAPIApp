//
//  addResponse.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 20.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import Foundation

struct AddResponse: Decodable{
    var status: Int
    var data: idResponse?
    var error: String?
}

struct idResponse: Decodable{
    var id: String
}
