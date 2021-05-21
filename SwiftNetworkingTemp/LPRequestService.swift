//
//  LPRequestService.swift
//  logisticsProduct
//
//  Created by 刘Sir on 2020/12/22.
//  Copyright © 2020 SSH. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

enum LPRequestService {
    // 司机，安装师傅注册效验
    case ALoginCheck(_ param: [String: Any])
    // 图片上传
    case AUploadImage(_ data: Data)
    // 司机，安装师傅注册
    case ALoginMasterRegister(_ param: [String: Any])
    // 维修师傅注册
    case ALoginWXMasterRegister(_ param: [String: Any])
    // 师傅车辆类型
    case ALoginSFType
    // 司机车辆类型
    case AloginSJ_car_type
    // 司机_师傅登陆
    case AlogonLogon(_ name: String, password: String)
    // 城配抢单列表
    case AOrderSJRobList(_ lon: String, lat: String)
    /** 司机管理订单(确认收货，确认送达)订单状态**/
    case AOrderEdit(_ order_id: String)
    // 城配订单列表 3：待收货 4：配送中 5：送货到达（待客户确认） 6：订单已完成
    case AOrderList(_ status: String)
    // 订单详情
    case AOrderInfo(_ order_id: String)
    // 申请提现
    case AMoneyApplyDep(_ apply_money: String)
    // 提现记录
    case AmoneyApplyInfo
    // 收支明细
    case AMoneyEaringRecord(_ times: String? = nil)
    // 获取个人信息
    case AUserInfo
    // 获取客服号码
    case AUserServicePhone
    // 报价抢单 (安装，维修通用)
    case ABJRaceOrder(_ order_id: String, money: String)
    // 安装抢单大厅
    case InstallRob_list
    // 安装师傅确认派送（确认收货，确认送达）
    case InstallEdit_order(_ order_id: String)
    // 安装师傅订单列表1：待处理，2：配送中，3：待结单，4：已完成
    case InstallOrder_list(_ status: String)
    // 安装师傅订单详情
    case InstallOrderDetail(_ order_id: String)
    // 维修抢单大厅
    case ServiceRob_list
    // 维修师傅列表1：待处理； 2：已完成
    case ServiceOrder_list(_ status: String)
    // 维修师傅确认维修（确认维修）
    case ServiceEdit_order(_ order_id: String)
    // 维修订单详情
    case ServiceOrderDetail(_ order_id: String)
    // 获取钱包余额
    case AUserGetMoney
    // 绑定银行卡
    case AUserBindBank(_ identity: String, bank_num: String, bank_phone: String)
    // 获取银行名
    case AUserGetBank
    // 修改用户信息
    case AUserEditInfo(_ param: [String: Any])
    // 获取银行卡号
    case AUserGetBankNum
    // 获取审核信息
    case AUserAuditData
    // 修改审核信息
    case AUserEditAudit(_ param: [String: Any])
    // 查看评价手机
    case ADriverPinJia(_ order_id: String)
    // 查看评价安装
    case AInstallPinJia(_ order_id: String)
    // 我的车辆
    case AUserMyCar
    // 修改师傅经纬度
    case AEditPlace(_ lng: String, lat: String)
    // 版本更新
    case APP_Update
    // 消息列表
    case AppOrderNews(_ page: Int, type: Int, xt_type: Int)
    // 获取验证码
    case AppSendCode(_ phone: String)
    // 退出登陆
    case AloginOut
    // 忘记密码
    case ALoginForgetPassword(_ phone: String, code: String, password: String, repass: String)
    // 重置密码
    case ALoginResetPassword(_ code: String, password: String, repass: String)
}

extension LPRequestService: TargetType {
    var path: String {
        switch self {
        case .ALoginCheck: return "Alogin/master_check"
        case .AUploadImage: return "Upload/uploadImg"
        case .ALoginMasterRegister: return "Alogin/master"
        case .ALoginWXMasterRegister: return "Alogin/master_wx"
        case .ALoginSFType: return "Alogin/sf_car_type"
        case .AloginSJ_car_type: return "Alogin/sj_car_type"
        case .AlogonLogon: return "Alogon/logon"
        case .AOrderSJRobList: return "a_order/sj_rob_list"
        case .AOrderEdit: return "a_order/sj_edit"
        case .AOrderList: return "a_order/sj_order_list"
        case .AMoneyApplyDep: return "a_money/apply_deposit"
        case .AmoneyApplyInfo: return "a_money/apply_info"
        case .AMoneyEaringRecord: return "a_money/get_earing_record"
        case .AUserInfo: return "a_user/get_user_message"
        case .AUserServicePhone: return "a_user/service"
        case .AOrderInfo: return "a_order/sj_order_ils"
        case .ABJRaceOrder: return "a_order/race_order"
        case .InstallRob_list: return "a_order/az_rob_list"
        case .InstallEdit_order: return "a_order/az_edit_order"
        case .InstallOrder_list: return "a_order/az_order_list"
        case .InstallOrderDetail: return "a_order/az_order_ils"
        case .ServiceRob_list: return "a_order/wx_rob_list"
        case .ServiceOrder_list: return "a_order/wx_order_list"
        case .ServiceEdit_order: return "a_order/wx_edit_order"
        case .ServiceOrderDetail: return "a_order/wx_order_ils"
        case .AUserGetMoney: return "a_user/get_money"
        case .AUserBindBank: return "a_user/bind_bank"
        case .AUserGetBank: return "a_user/get_bank"
        case .AUserEditInfo: return "a_user/edit_user"
        case .AUserGetBankNum: return "a_user/get_bank_num"
        case .AUserAuditData: return "a_user/audit_data"
        case .AUserEditAudit: return "a_user/edit_audit"
        case .ADriverPinJia: return "a_order/cp_pinjia"
        case .AInstallPinJia: return "a_order/az_pinjia"
        case .AUserMyCar: return "a_user/my_car"
        case .AEditPlace: return "a_user/edit_place"
        case .APP_Update: return "a_user/get_release"
        case .AppOrderNews: return "a_order/order_news"
        case .AppSendCode: return "Asms/sendsms"
        case .AloginOut: return "Alogon/out"
        case .ALoginForgetPassword: return "Alogon/password"
        case .ALoginResetPassword: return "Alogon/reset_pass"
        }
    }
    var method: Moya.Method {
        switch self {
        default: return .post
        }
    }
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .ALoginCheck(let param):
            params = param
        case .AUploadImage(let data):
            let formData = Moya.MultipartFormData(provider: .data(data), name: "img", fileName: "filename.png", mimeType: "png")
            return .uploadCompositeMultipart([formData], urlParameters: params)
        case .ALoginMasterRegister(let param):
            params = param
        case .ALoginWXMasterRegister(let param):
            params = param
        case .ALoginSFType,
             .AloginSJ_car_type,
             .AmoneyApplyInfo,
             .AUserInfo,
             .AUserServicePhone,
             .InstallRob_list,
             .ServiceRob_list,
             .AUserGetBank,
             .AUserGetMoney,
             .AUserGetBankNum,
             .AUserAuditData,
             .AUserMyCar,
             .AloginOut:
            break
        case .AlogonLogon(let username, let password):
            params["username"] = username
            params["password"] = password
        case .AOrderSJRobList(let lon, let lat):
            params["lon"] = lon
            params["lat"] = lat
        case .AOrderEdit(let order_id),
             .AOrderInfo(let order_id),
             .InstallEdit_order(let order_id),
             .InstallOrderDetail(let order_id),
             .ServiceEdit_order(let order_id),
             .ServiceOrderDetail(let order_id),
             .ADriverPinJia(let order_id),
             .AInstallPinJia(let order_id):
            params["order_id"] = order_id
        case .AOrderList(let status),
             .InstallOrder_list(let status),
             .ServiceOrder_list(let status):
            params["status"] = status
        case .AMoneyApplyDep(let apply_money):
            params["apply_money"] = apply_money
        case .ABJRaceOrder(let order_id, let money):
            params["order_id"] = order_id
            params["money"] = money
        case .AMoneyEaringRecord(let times):
            params["times"] = times
        case .AUserBindBank(let identity, let bank_num, let bank_phone):
            params["identity"] = identity
            params["bank_num"] = bank_num
            params["bank_phone"] = bank_phone
        case .AUserEditInfo(let param),
             .AUserEditAudit(let param):
            params = param
        case .AEditPlace(let lon, let lat):
            params["lng"] = lon
            params["lat"] = lat
        case .APP_Update:
            params["type"] = "ios"
        case .AppOrderNews(let page, let type, let xt_type):
            params["page"] = page
            params["type"] = type
            params["xt_type"] = xt_type
        case .AppSendCode(let phone):
            params["phone"] = phone
        case .ALoginForgetPassword(let phone, let code, let password, let repass):
            params["phone"] = phone
            params["code"] = code
            params["password"] = password
            params["repass"] = repass
        case .ALoginResetPassword(let code, let password, let repass):
            params["code"] = code
            params["password"] = password
            params["repass"] = repass
        }
//        if let token = LPUserServices.shared.loginUser {
//            params["token"] = token.token
//        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    var headers: [String: String]? {
        let contentType = "application/x-www-form-urlencoded;"
        let header = [
            "Content-Type": "\(contentType) charset=UTF-8;",
            "Accept": "*/*",
        ]
        return header
    }
}
