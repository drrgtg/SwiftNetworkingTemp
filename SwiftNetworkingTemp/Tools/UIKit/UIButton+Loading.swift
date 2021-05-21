//
//  UIButton+Loading.swift
//  iOSAppNext
//
//  Created by Alex on 2019/12/30.
//  Copyright © 2019 -. All rights reserved.
//

import UIKit

extension UIButton {
    private struct AssociatedKeys {
        static var originalTitleKey = 0
        static var activityIndicatorKey = 0
    }
    
    private var originalTitle: String? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.originalTitleKey) as? String }
        set { objc_setAssociatedObject(self, &AssociatedKeys.originalTitleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.originalTitleKey) as? UIActivityIndicatorView }
        set { objc_setAssociatedObject(self, &AssociatedKeys.originalTitleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func showLoading() {
        originalTitle = self.title(for: .normal)
        self.setTitle("", for: .normal)

        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }

        showSpinning()
    }
    
    func hideLoading() {
        guard let activityIndicator = self.activityIndicator else { return }
        if let title = self.title(for: .normal), title.count > 0 {
        } else {
            self.setTitle(originalTitle, for: .normal)
        }
        activityIndicator.stopAnimating()
        isUserInteractionEnabled = true
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }

    private func showSpinning() {
        guard let activityIndicator = self.activityIndicator else { return }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
        isUserInteractionEnabled = false
    }

    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
