//
//  ClientInfoService.swift
//  GCCX
//
//  Created by Eric on 2019/8/6.
//  Copyright © 2019 Migrsoft Software Inc. All rights reserved.
//

import CoreTelephony
import Alamofire
import UIKit

class ClientInfoService: HandyJSON {
    required init() {
        operatorName = UIDevice.carrierName()
    }

    /// 运营商,与Android一样传IMSI
    var operatorName: String?

    /// Simulator   型号
    var device = UIDevice().name

    var imei = CRIdfa
    // 获取的mac地址有误，需重新设置
//    var mac = UIDevice.getMACAddress().first
    var clientType = 1

    /// wifi
    var network: String = {
        var network = "WIFI"
        if let networkStatus = NetworkReachabilityManager()?.status {
            switch networkStatus {
            case .notReachable, .unknown:
                break
            case let .reachable(conType):
                if conType == .cellular {
                    network = "4G"
                } else {
                    network = "WIFI"
                }
            }
        }
        return network
    }()

    /// 包名
    var pkgName = Bundle.main.bundleIdentifier

    /// iOS
    var systemType = UIDevice.current.systemName

    /// 11.4
    var systemVersion = UIDevice.current.systemVersion

    /// appstore    渠道
    var vendor = UIDevice.current.systemName
    var version = CRAppVersionShort

    /// 返回美洽字段
    ///
    /// - Returns: <#return value description#>
    class func meiQiaClientInfo() -> [String: String] {
        var userInfo = [String: String]()
        userInfo["状态"] = "正常"
        userInfo["版本号"] = CRAppVersionShort
        userInfo["系统"] = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        var network = "WIFI"
        if let networkStatus = NetworkReachabilityManager()?.status {
            switch networkStatus {
            case .notReachable, .unknown:
                break
            case let .reachable(conType):
                if conType == .cellular {
                    network = "4G"
                } else {
                    network = "WIFI"
                }
            }
        }
        userInfo["网络"] = network
        userInfo["设备号"] = CRIdfa
        userInfo["运营商"] = UIDevice.carrierName() ?? kEmptyString
        return userInfo
    }
}
