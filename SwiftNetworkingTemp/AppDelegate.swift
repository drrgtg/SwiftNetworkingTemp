//
//  AppDelegate.swift
//  SwiftNetworkingTemp
//
//  Created by jauok on 2021/5/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Reqest demo
        
        
        /*
         
         let api = LPRequestService.AlogonLogon(name, password: password)
         Network.request(api, dataType: JSON.self, showErrorMsg: true)
         .do(onSuccess: { [weak self] (data) in
             guard let token = data.data?.string else {
                 return
             }
             print(token)
         }, onError: {[weak self] (err) in
             Toast.hideLoading(from: self?.view)
         }, onDispose: { [weak self] in
         })
         .subscribe()
         .disposed(by: disposeBag)
         */
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

