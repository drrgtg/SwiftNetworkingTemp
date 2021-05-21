//
//  APIError.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/25.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation

let kAPISuccessCode = 1
let kAPIFailure = 0
let kAccessTokenExpiredCode = -1
let kAPIRegisterEnableCode    = 20025
struct APIError: Swift.Error {
    let code: Int
    let message: String
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
    
    var localizedDescription: String {
        message
    }
}


extension URLError {
    
    init(statusCode: Int) {
        self.init(.unknown)
    }
}
