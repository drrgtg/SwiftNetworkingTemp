//
//  UIImageView+Url.swift
//  KuaiDou
//
//  Created by lsp on 2020/6/4.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    @objc func setUrlImageWith(url :URL?, placeholderImage: UIImage? = nil) {
        // 滑动禁止
        self.sd_setImage(with: url, placeholderImage: placeholderImage)
    }
    @objc func setUrlImageWith(url :URL?, placeholderImage: UIImage? = nil, animation: Bool = false) {
        if animation {
            self.sd_imageTransition = SDWebImageTransition.fade
        }
        self.setUrlImageWith(url: url, placeholderImage: placeholderImage)
    }
}
