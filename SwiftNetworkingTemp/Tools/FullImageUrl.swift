//
//  FullImageUrl.swift
//  logisticsProduct
//
//  Created by 刘Sir on 2020/12/22.
//  Copyright © 2020 SSH. All rights reserved.
//

import Foundation


extension URL {
    static func fullImageUrl(_ path: String) -> URL? {
        URL(string: baseUrl)?.appendingPathComponent(path)
    }
}
