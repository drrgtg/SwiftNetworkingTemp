//
//  ResponseModelConvertible.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/24.
//  Copyright © 2019 -. All rights reserved.
//

@_exported import Foundation
@_exported import SwiftyJSON
@_exported import HandyJSON
@_exported import RxSwift
@_exported import Moya

protocol ResponseMappable {
    associatedtype Data
    
    var status: Int { get }
    var info: String { get }
    var url: String { get }
    var data: Data? { get }
    
    static func transform(_ response: Response, failsOnEmptyData: Bool) throws -> Self
    static func transform(from response: Any?) -> Self?
}

extension ResponseMappable {
    func isSuccess() -> Bool {
        status == 1
    }
}

extension JSON: ResponseMappable {
    typealias Data = JSON
    
    var info: String { self[JSON_INFO_KEY].stringValue }
    
    var status: Int   { self[JSON_STATUS_KEY].intValue }
    var url: String { self[JSON_URL_KEY].stringValue }
    var data: Data? { self[JSON_DATA_KEY] }
    
    static func transform(_ response: Response, failsOnEmptyData: Bool = true) throws -> JSON {
        let jsonObj = try response.mapJSON(failsOnEmptyData: failsOnEmptyData)
        return JSON(jsonObj)
    }
    
    static func transform(from response: Any?) -> JSON? {
        if let dict = response as? [String:Any] {
            return JSON(dict)
        }
        return nil
    }
}

extension JSON: HandyJSONCustomTransformable {
    
    public static func _transform(from object: Any) -> Self? {
        return JSON(object)
    }
    
    public func _plainValue() -> Any? {
        return self.object
    }
}

class ResponseModel<DataType>: ResponseMappable, HandyJSON {
    typealias Data = DataType
    
    
    var status: Int = 0
    var info: String = ""
    var url: String = ""
    var data: Data? = nil
    
    required init() {}
    
    init(data: Data?) {
        self.data = data
    }
    
    static func transform(_ response: Response, failsOnEmptyData: Bool = true) throws -> Self {
        guard let jsonObj = try response.mapJSON(failsOnEmptyData: failsOnEmptyData) as? [String: Any] else {
            throw MoyaError.jsonMapping(response)
        }
        return JSONDeserializer<ResponseModel<Data>>.deserializeFrom(dict: jsonObj) as! Self
    }
    
    static func transform(from response: Any?) -> Self? {
        if let dict = response as? [String:Any] {
            return JSONDeserializer<ResponseModel<Data>>.deserializeFrom(dict: dict) as? Self
        }
        return nil
    }
}

extension Response {
    
    func map<T: ResponseMappable>(type: T.Type, failsOnEmptyData: Bool = true) throws -> T {
        return try T.transform(self, failsOnEmptyData: failsOnEmptyData)
    }
}

//MARK: - RxSwift Extensions

extension ObservableType where Element == Response {
    
    func map<T: ResponseMappable>(type: T.Type, failsOnEmptyData: Bool = true) -> Observable<T> {
        return flatMap { Observable.just(try $0.map(type: type, failsOnEmptyData: failsOnEmptyData)) }
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func map<T: ResponseMappable>(type: T.Type, failsOnEmptyData: Bool = true) -> Single<T> {
        return flatMap { .just(try $0.map(type: type, failsOnEmptyData: failsOnEmptyData)) }
    }
}

//MARK: - Progress Response

extension ProgressResponse {
    func map<T>(type: T.Type, failsOnEmptyData: Bool = true) throws -> (Double, T?) where T: ResponseMappable {
        (progress, try response?.map(type: T.self, failsOnEmptyData: failsOnEmptyData))
    }
}

extension ObservableType where Element == ProgressResponse {
    func map<T>(type: T.Type, failsOnEmptyData: Bool = true) -> Observable<(Double, T?)> where T: ResponseMappable {
        return flatMap { e in
            return Observable.create { (observer) -> Disposable in
                do {
                    let t = try e.map(type: type, failsOnEmptyData: failsOnEmptyData)
                    observer.onNext(t)
                } catch {
                    observer.onError(error)
                }
                return Disposables.create()
            }
        }
    }
}
