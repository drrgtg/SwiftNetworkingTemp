//
//  GloableAPI.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2020/1/19.
//  Copyright © 2020 -. All rights reserved.
//

import Foundation

/// Gloable APIs

enum GloableAPI {
    // 版本号获取
    case version
    
    // 获取IP地址
    case getip
    
    // 获取客户端配置信息
    case getPhoneDict
    
    /// 通过类型获取配置信息
    case getDictByType(type: String)
    
    /// 获取礼物详情
    case getGifts
    
    /// 打赏 targetUserId 接收人id；  type 消费类型，1为视频，2为消息
    case rewardOrder(giftId: Int, num: Int = 1, targetUserId: Int, type: Int, videoId: Int? = nil)
    
    /// 获取分享信息分享类型 1邀请好友 2个人主页 3视频分享 4话题分享 扩展参数 用户ID=userId 视频ID=videoId 话题ID=topicId 邀请码=inviteCode
    case getShareUrlInfo(shareType: Int, extParam: [String: Any])
    /// 获取安装包
    case getInstallationPackage
}

extension GloableAPI: TargetType {
    
    var task: Task {
        var params = [String: Any]()
        //            params["<#key#>"] = <#value#>
        switch self {
        case .version:
            params["type"] = "ios"
            
        case .getip:
            return .requestPlain
            
        case .getPhoneDict:
            return .requestPlain
    
        case let .getDictByType(type):
            params["type"] = type
            
        case .getGifts: break
        case let .rewardOrder(giftId, num, targetUserId, type, videoId):
            params["giftId"] = giftId
            params["num"] = num
            params["targetUserId"] = targetUserId
            params["type"] = type
            params["videoId"] = videoId
        case let .getShareUrlInfo(shareType, extParam):
            params["shareType"] = shareType
            params["extParam"] = extParam
        case .getInstallationPackage: break
        }
        //setDefaultParams(&params)
        return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
    
    var path: String {
        switch self {
        case .version:
            return "/home/version"
        case .getip:
            return "/user/getip"
        case .getPhoneDict:
            return "/system/v1/cfg/public/getPhoneDict"
        case .getDictByType:
            return "/system/v1/cfg/public/getDictByType"
        case .getGifts:
            return "/system/v1/cfg/public/getGifts"
        case .rewardOrder:
            return "/transaction/v1/order/rewardOrder"
        case .getShareUrlInfo:
            return "/video/v1/common/public/getShareUrlInfo"
        case .getInstallationPackage:
            return "/system/v1/sys/public/installationPackage"
        }
    }
}
