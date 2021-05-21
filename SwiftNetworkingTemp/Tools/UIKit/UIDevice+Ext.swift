//
//  UIDevice+Ext.swift
//  KuaiDou
//
//  Created by Jin Sun on 2020/7/20.
//  Copyright © 2020 iFeng1. All rights reserved.
//

import UIKit
import CoreTelephony

extension UIDevice {
    
    /// 获取运营商名称
    class func carrierName() -> String? {
        let info = CTTelephonyNetworkInfo()
        if #available(iOS 12.0, *) {
            if let carrier = info.serviceSubscriberCellularProviders?.first?.value {
                return carrier.carrierName
            }
        } else {
            let carrier = info.subscriberCellularProvider
            return carrier?.carrierName
        }
        return ""
//        CTCarrier *carrier = [info subscriberCellularProvider];
//        NSString *mcc = [carrier mobileCountryCode]; // 国家码 如：460
//        NSString *mnc = [carrier mobileNetworkCode]; // 网络码 如：01
//        NSString *name = [carrier carrierName]; // 运营商名称，中国联通
//        NSString *isoCountryCode = [carrier isoCountryCode]; // cn
//        BOOL allowsVOIP = [carrier allowsVOIP];// YES
//        NSString *radioAccessTechnology = info.currentRadioAccessTechnology; // 无线连接技术，如CTRadioAccessTechnologyLTE
    }

    class func getMACAddress() -> [String] {
        var addresses = [String]()
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }

        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            let addr = ptr.pointee.ifa_addr.pointee

            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP | IFF_RUNNING | IFF_LOOPBACK)) == (IFF_UP | IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                   nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }
        freeifaddrs(ifaddr)
        return addresses
    }
}
