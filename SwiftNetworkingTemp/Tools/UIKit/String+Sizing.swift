//
//  String+Sizing.swift
//  NMWeiShi
//
//  Created by Jin Sun on 2020/5/7.
//

import Foundation

extension String {
    
    public func sizeWithFont(font: UIFont?, maxSize: CGSize) -> CGSize {
        let text = self as NSString
        if font != nil {
            let attrs = [NSAttributedString.Key.font: font!]
            let rect = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            return rect.size
        }
        return CGSize.zero
    }
    
    public func widthWithFont(font: UIFont?) -> CGFloat {
        return sizeWithFont(font: font, maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
    }
    
    public func heightForFont(font: UIFont?, width: CGFloat) -> CGFloat {
        return sizeWithFont(font: font, maxSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
    }
}


extension NSAttributedString {
    
    @objc
    public func sizeThatFits(size: CGSize) -> CGSize {
        let rect = boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return rect.size
    }
    
    @objc
    public func widthToFit() -> CGFloat {
        let size = sizeThatFits(size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        return size.width
    }
    
    @objc
    public func heightForWidth(width: CGFloat) -> CGFloat {
        let size = sizeThatFits(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
}
