//
//  UIFont+Custom.swift
//  
//
//  Created by Alex on 2020/2/13.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import UIKit

extension UIFont {
    
    @objc
    class func pingFangRegular(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    @objc
    class func pingFangMedium(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }

    @objc
    class func pingFangSemibold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Semibold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }

    @objc
    class func pingFangBold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    @objc
    class func pingFangHeavy(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Heavy", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .heavy)
    }
}
