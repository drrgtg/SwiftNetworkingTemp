//
//  UIImage+String.swift
//  KuaiDou
//
//  Created by lsp on 2020/5/29.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

extension String {
    func stringToImage(font: UIFont = .pingFangSemibold(ofSize: 15)) -> UIImage {
        let size = CGSize(width: 49, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        let context = UIGraphicsGetCurrentContext();
        // color
        context?.setFillColor(UIColor.clear.cgColor);
        context?.fill(rect);
        // text
        let textSize = self.size(withAttributes:[.font : font])
        let drawRect = CGRect(x: (size.width - textSize.width) / 2.0, y: (size.height - textSize.height) / 2.0, width: textSize.width+2, height: textSize.height)
        (self as NSString).draw(in: drawRect, withAttributes: [.font: font])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
