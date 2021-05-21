//
//  Constants.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/23.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import AdSupport

// 一些常量

public let CRCOMPS_DATE: [Calendar.Component] = [.year, .month, .day]
public let CRCOMPS_TIME: [Calendar.Component] = [.hour, .minute, .second]

let bundleId = String(CFBundleGetIdentifier(CFBundleGetMainBundle()))
let buildNum = Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String
let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String

let LOCALE_CN = NSLocale(localeIdentifier: "zh_Hans_CN")


let CRAppBuild = Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String
let CRAppVersionShort = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let CRAppName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
let CRIdfv = UIDevice.current.identifierForVendor?.uuidString
let CRIdfa: String = {
    let cache = UserDefaults.standard.object(forKey: "kUUID_CacheData")
    if let oldValue: String = (cache as? String) {
        return oldValue
    } else {
        let newValue = NSUUID().uuidString
        UserDefaults.standard.set(newValue, forKey: "kUUID_CacheData")
        return newValue
    }
}()

let IS_IPHONEX: Bool = {
    let screenHeight = UIScreen.main.bounds.height
    return screenHeight > 811
}()

var SCREEN_WIDTH: CGFloat {
    return UIScreen.main.bounds.width
}
var SCREEN_HEIGHT: CGFloat {
    return UIScreen.main.bounds.height
}
var SCREEN_SCALE: CGFloat {
    return UIScreen.main.scale
}
var TABBAR_HEIGHT: CGFloat {
    var navh: CGFloat = 0.0
    if #available(iOS 11.0, *) {
        navh += CGFloat((UIApplication.shared.delegate?.window?!.safeAreaInsets.bottom)!)
    }else{
        navh += 0
    }
    return navh + 49
}

var STATUS_BAR_HEIGHT: CGFloat {
    if #available(iOS 13.0, *) {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        return statusBarManager?.statusBarFrame.height ?? 20.0
    } else {
        // Fallback on earlier versions
        return UIApplication.shared.statusBarFrame.height
    }
}
let screenWidthScale = SCREEN_WIDTH / 375.0

let ONE_PIXEL = 1 / UIScreen.main.scale


let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
let libDir = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
let cachesDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
let tmpDir = NSTemporaryDirectory()

public typealias CRVoidBlock = () -> Void
public typealias CRCompletionTask = CRVoidBlock
public typealias CRBoolBlock = (Bool) -> Void



//MARK: - <#mark#>
//let kWechatText = "微信"
//let kAipayText = "支付宝"
//let kBankText = "银行卡"
//let kFPM = "FPM"
//let kDGPT = "DGPT"
//let kUSDT = "USDT"

//MARK: - 常用正则表达式

/// 正则表达式：判断是否是十进制数字
/// - Parameter accuracy: 最大精度
public func REPatternDecimal(accuracy: Int) -> String {
    "^[0-9]*.?[0-9]{0,\(accuracy)}$"
}

/// 正则表达式：判断是否符合身份证号格式
let REPatternChinaIDCard = "(^\\d{15}$)|(^\\d{17}([0-9]|X)$)"
/// 输入时判断使用
let REPatternChinaIDCardForInput = "(^\\d{0,15}$)|(^\\d{0,17}([0-9]|X)$)"

/* 正则表达式：判断是否符合手机号格式
 * 
 * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
 * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
 * 电信号段: 133,149,153,170,173,177,180,181,189
 * "^[1][3-9][0-9]{9}$"
 */
let REPatternMobilePhoneNumber = "^(\\+\\d{2}-)?(\\d{2,3}-)?([1][3-9][0-9]{9})$"
/// 输入时判断使用
let REPatternMobilePhoneNumberForInput = "^(\\+\\d{0,2}-)?(\\d{0,3}-)?([1][3-9][0-9]{0,9})$"

/// 正则表达式：判断是否符合邮箱地址格式
let REPatternEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
/// 输入时判断使用
//let REPatternEmailForInput = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
/// 正则表达式：判断是否是6到14位字母数字组合
let REPatternPassword = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{14}$"

/*
 * 判断是否符合 URL 格式
 * // (https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]
 */
let REPatternURL = "(https?)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"


// 判断是否是整数
let REPatternInteger = "^\\d+$"


//MARK: - Symbols

public let kBracketBigBegin = "{"
public let kBracketBigEnd = "}"
public let kSeparatorComma = ","
public let kSeparatorSlash = "/"
public let kSeparatorDot = "."
public let kSymbolQuestion = "?"
public let kSeparatorBitAnd = "&"
public let kSymbolEqual = "="
public let kWhitespace = " "
public let kEmptyString = ""
public let kSeparatorSolidDot = "●"



////全局定义t通用代码回调
//typealias callBlock = (String) -> Void // 定义一个闭包类型（typealias：特定的函数类型函数类型）
typealias callBlock = (String) -> Void




public let kGDAmapiKey = "aea9eaa6b11cff7172dafe2fead2c6af"



let defaultPersonHeaderImageString = "icon_person_default"
let defaultPicImageString = "icon_pic_placeholder"
