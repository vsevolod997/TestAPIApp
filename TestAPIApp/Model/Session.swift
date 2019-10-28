//
//  Session.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 18.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import Foundation

class SessionSingeltone{
    static let session = SessionSingeltone()
    var tokenStrings:String = ""
    
    private init(){}
}
