//
//  BaseURLConfig.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/25.
//  Copyright © 2019 -. All rights reserved.
//

import Moya
import MobileCoreServices

/*
 ⚠️⚠️⚠️⚠️⚠️⚠️ ATTENTION: ⚠️⚠️⚠️⚠️⚠️⚠️
 如果需要上架 App Store，请务必使用 https 请求
 并且删除 info.plist 中的 App Transport Security Settings -> Allow Arbitrary Loads
 */

var baseUrl: String {
    return "https://www.xuhuanshijian.cn/wlxt"
}

/// 应用内拼 H5 链接时使用
var hostUrl: String {
    let url = URL(string: baseUrl)!
    return "\(url.scheme!)://\(url.host!)"
}

//MARK: - TargetType 默认实现
// 如果需要定制，请在对应的 Target 中重写
extension TargetType {
    
    // 默认域名，如果有连接其他域名的 api，请在对应的 Target 中重写
    var baseURL: URL {
        return URL(string: baseUrl.appending("/smapi"))!
    }
    
    // 默认请求方式，如果需要定制请在对应的 Target 中重写
    var method: Moya.Method {
        return .post
    }
    
    // 默认单元测试模拟数据
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    // 默认请求头
    var headers: [String : String]? {
        var headers: [String : String] = [:]
        if let json = ClientInfoService().toJSONString() {
            let urlJson = json.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            headers["clientInfo"] = urlJson
        }
        headers["Content-Type"] = "application/json; charset=UTF-8"
        return headers
    }
}

//MARK: - TargetType 工具方法
extension TargetType {
    
    // 设置默认请求参数，按需调用
    func setDefaultParams(_ params: inout [String: Any]) {
        print(params)
    }

    
    func signParams(_ params: [String: Any], with key: String) -> [String: String]? {
        return ["sign": "sign", "reqData": "reqData"]
    }
    
    func signedTask(with key: String, ignoreSignKey: String) -> Task {
        let task = self.task
        switch task {
        case .requestPlain:
            if let signedParams = signParams([:], with: key)
            {
                return .requestParameters(parameters: signedParams, encoding: JSONEncoding.default)
            } else {
                return task
            }
        case let .requestParameters(params, encoding):
            if params[ignoreSignKey] == nil,
                let signedParams = signParams(params, with: key)
            {
                return .requestParameters(parameters: signedParams, encoding: encoding)
            } else {
                return task
            }
        default:
            return task
        }
    }
    
    // 根据后缀查询 mime type
    func mimeTypeFor(pathExtension: String) -> String {
        if
            let id = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)?.takeRetainedValue(),
            let contentType = UTTypeCopyPreferredTagWithClass(id, kUTTagClassMIMEType)?.takeRetainedValue()
        {
            return contentType as String
        }

        return "application/octet-stream"
    }
}

