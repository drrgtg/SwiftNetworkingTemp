//
//  UIViewController+BackButtonHandler.swift
//  GCCX
//
//  Created by Eric Wu on 2019/7/8.
//  Copyright Β© 2019 Migrsoft Software Inc. All rights reserved.
//

#if canImport(QMUIKit)

// πππππππππππππππππππππ
// ε¦ζδ½Ώη¨δΊ QMUIKit
// δ½Ώη¨ UINavigationControllerBackButtonHandlerProtocol
// UINavigationController+QMUI
// πππππππππππππππππππππ

#else

import UIKit

public protocol BackButtonHandlerProtocol {
    func shouldPopViewController(byBackButtonOrPopGesture byPopGesture: Bool) -> Bool
}
extension BackButtonHandlerProtocol {
    public func shouldPopViewController(byBackButtonOrPopGesture byPopGesture: Bool) -> Bool {
        return true
    }
}

extension UIViewController: BackButtonHandlerProtocol {}

extension UINavigationController: UINavigationBarDelegate {
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if viewControllers.count < navigationBar.items?.count ?? 0 {
            return true
        }
        var shouldPop = true
        if let ctrl = topViewController {
            shouldPop = ctrl.shouldPopViewController(byBackButtonOrPopGesture: false)
        }
        if shouldPop {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        } else {
            // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
            navigationBar.subviews.forEach { subView in
                if 0 < subView.alpha && subView.alpha < 1 {
                    UIView.animate(withDuration: 0.25, animations: {
                        subView.alpha = 1
                    })
                }
            }
        }
        return false
    }
}

#endif /* canImport(QMUIKit) */
