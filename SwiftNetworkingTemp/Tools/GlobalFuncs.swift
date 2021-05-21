//
//  GlobalFuncs.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/23.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import RxCocoa
import CoreLocation

// 全局函数
//MARK: - Utility

public let decimalFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = false
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 16
    return formatter
}()

public func keyWindow() -> UIWindow {
    var keyWindow = UIApplication.shared.keyWindow
    if keyWindow == nil {
        let windows = UIApplication.shared.windows.filter { (win) -> Bool in
            !win.isHidden && win.alpha > 0 && win.bounds != .zero 
        }
        keyWindow = windows.last
    }
    return keyWindow!
}

public func CRMainWindow() -> UIWindow {
    var mainWindow: UIWindow? = UIApplication.shared.delegate?.window ?? nil
    if mainWindow == nil {
        let arrWindow = UIApplication.shared.windows
        if arrWindow.count > 0 {
            mainWindow = arrWindow.first
        }
    }
    return mainWindow!
}

public func CRScreenBounds() -> CGRect {
    let landscape = UIDevice.current.orientation.isLandscape
    var rect = UIScreen.main.bounds
    if landscape && rect.width < rect.height {
        let height = rect.height
        rect.size.height = rect.width
        rect.size.width = height
    }
    return rect
}
public func CommentPlaceHolderText() -> String {
    let placeHolders = ["积极发言是一种美德", "发表你的看法，帮助他人成长", "留个言，让我看看你有趣的灵魂", "良言一句三冬暖", "文明人发言，就像玫瑰在吐露芬芳", "那么精彩的内容，不留个言吗？", "精彩的内容和你精彩的留言最配", "555...你确定不说点什么吗？", "传递正能量，从留言开始"]
    let count = UInt32(placeHolders.count)
    let randomIndex = Int(arc4random()%count)
    return placeHolders[randomIndex]
}

@discardableResult
public func ensureExistsOfDirectory(dirPath: String) -> Bool {
    var isDir = ObjCBool(false)
    if !FileManager.default.fileExists(atPath: dirPath, isDirectory: &isDir) || !isDir.boolValue {
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("createDirectory error :\(error.localizedDescription)")
        }
    }
    return true
}

//MARK: - 输入值校验

public func CRIsNullOrEmpty(text: String?) -> Bool {
    guard (text as Any) is String, let str = text, !str.isEmpty else { return true }
    return false
}

public func CRMatches(pattern: String, text: String?) -> [NSTextCheckingResult]? {
    guard let string = text else { return nil }
    if string.count <= 0 {
        return nil
    }
    if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
        return regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
    }
    return nil
}

public func CRMatch(pattern: String, text: String?) -> NSTextCheckingResult? {
    return CRMatches(pattern: pattern, text: text)?.first
}

public func CRIsMatch(pattern: String, text: String?) -> Bool {
    if CRIsNullOrEmpty(text: text) {
        return false
    }
    if CRMatch(pattern: pattern, text: text) == nil {
        return false
    }
    return true
}

public func CRIsEmail(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternEmail, text: text)
}

/**
 * 判断字符串是否符合手机号码格式
 * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
 * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
 * 电信号段: 133,149,153,170,173,177,180,181,189
 * @param text 待检测的字符串
 * @return 待检测的字符串
 */
public func CRIsPhoneNumber(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternMobilePhoneNumber, text: text)
}

public func CRIsInteger(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternInteger, text: text)
}

public func CRIsURL(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternURL, text: text)
}

public func CRIsPassWrod(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternPassword, text: text)
}
/// 判断是否符合身份证号格式
/// - Parameter text: 待验证的字符串
@discardableResult
public func CRIsIDCard(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternChinaIDCard, text: text)
}

/// 判断纬度是否有效
/// - Parameter lat: 纬度
public func IsValidLatitude(_ lat: Double) -> Bool {
    return -90 <= lat && lat <= 90
}

/// 判断经度是否有效
/// - Parameter lon: 经度
public func IsValidLongitude(_ lon: Double) -> Bool {
    return -180 <= lon && lon <= 180
}

//MARK: - 距离计算

public func distanceReadable(from: CLLocation, to: CLLocation) -> String? {
    let meters = to.distance(from: from)
    decimalFormatter.maximumFractionDigits = 2
    let km = decimalFormatter.string(from: NSNumber(value: (meters / 1000.0)))
    return km == nil ? nil : "\(km!)千米"
}


//MARK: - 拨打电话

public func CRCallPhoneNumber(phone: String?) {
    if CRIsNullOrEmpty(text: phone) {
        return
    }
    
    if let url = URL(string: "tel:\(phone!)") {
        UIApplication.shared.open(url, options: [:]) { (success) in
            // success=选择 呼叫 为 1  选择 取消 为0
            print("Open Phone Success \(success)")
        }
    }
}
// MARK: - 清除本地缓存
public func resetCache() {
    //cache文件夹
    let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    //文件夹下所有文件
    let files = FileManager.default.subpaths(atPath: cachePath!)!
    //遍历删除
    for file in files {
        //文件名
        let path = cachePath! + "/\(file)"
        //存在就删除
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                print("出错了！")
            }
        }
    }
}

//MARK: - JSON

@discardableResult
public func CRJSONFromPath(path: String) -> Any? {
    if let jsonData = NSData(contentsOfFile: path) {
        if let json = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) { return json }
    }
    return nil
}

@discardableResult
public func CRJSONFromString(string: String?) -> Any? {
    if let text = string {
        if let jsonData = text.data(using: .utf8) {
            if let json = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) { return json }
        }
    }
    return nil
}

@discardableResult
public func CRJSONToString(_ obj: Any) -> String? {
    if let data = try? JSONSerialization.data(withJSONObject: obj, options: []) {
        if let json = String(data: data, encoding: .utf8) {
            return json
        }
    }
    return nil
}


//MARK: - Type Casting
// workaround for Swift compiler bug, cheers compiler team :)
func castOptionalOrFatalError<T>(_ value: Any?) -> T? {
    if value == nil {
        return nil
    }
    let v: T = castOrFatalError(value)
    return v
}

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw myCastingError(object, targetType: resultType)
    }

    return returnValue
}

func castOptionalOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T? {
    if NSNull().isEqual(object) {
        return nil
    }

    guard let returnValue = object as? T else {
        throw myCastingError(object, targetType: resultType)
    }

    return returnValue
}

func castOrFatalError<T>(_ value: Any!, message: String) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        myFatalError(message)
    }
    
    return result
}

func castOrFatalError<T>(_ value: Any!) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        myFatalError("Failure converting from \(String(describing: value)) to \(T.self)")
    }
    
    return result
}

func myCastingError<T>(_ object: Any, targetType: T.Type) -> Error {
    RxCocoaError.castingError(object: object, targetType: targetType)
}

func myFatalError(_ lastMessage: String) -> Never  {
    // The temptation to comment this line is great, but please don't, it's for your own good. The choice is yours.
    fatalError(lastMessage)
}
