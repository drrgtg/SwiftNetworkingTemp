//
//  UIImage+QRCode.swift
//  NMWeiShi
//
//  Created by Jin Sun on 2020/5/7.
//

import UIKit

extension UIImage {
    
    public class func qrImageWithString(_ codeStr: String?) -> UIImage? {
        guard let codeStr = codeStr, !codeStr.isEmpty,
            let filter = CIFilter(name: "CIQRCodeGenerator")
            else { return nil }
        // 滤镜恢复默认设置
        filter.setDefaults()
        // 2. 给滤镜添加数据
        let data = codeStr.data(using: String.Encoding.utf8)
        filter.setValue(data, forKey: "inputMessage")
        // 3. 生成高清二维码 CIImage
        if let image = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
            let output = image.transformed(by: transform)
            // 解决图片无法保存
            let context = CIContext(options: nil)
            if let bitmapImage = context.createCGImage(output, from: output.extent) {
                // 4. 显示二维码
                let newImage = UIImage(cgImage: bitmapImage, scale: UIScreen.main.scale, orientation: UIImage.Orientation.up)
                return newImage
            }
        }
        return nil
    }
    
    public class func imageSizeWithURL(_ url: String?) -> CGSize {
        guard let urlStr = url, let trimUrl = URL(string: urlStr) else {
            return CGSize.zero
        }
        // https://github.com/mattneub/Programming-iOS-Book-Examples/blob/master/bk2ch23p829imageIO/ch36p1084imageIO/ViewController.swift
        var width: CGFloat = 0
        var height: CGFloat = 0
        if let imageSRef = CGImageSourceCreateWithURL(trimUrl as CFURL, nil),
            let imageP = CGImageSourceCopyPropertiesAtIndex(imageSRef, 0, nil)
        {
            let imageDict = imageP as Dictionary
            width = imageDict[kCGImagePropertyPixelWidth] as! CGFloat
            height = imageDict[kCGImagePropertyPixelHeight] as! CGFloat
        }
        return CGSize(width: width, height: height)
    }
    
    public static func createImgfrom(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    public func containsQrCode() -> Bool {
        if let decodeImage = CIImage(image: self),
            let dector = CIDetector(ofType: CIDetectorTypeQRCode, context: CIContext(), options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]),
            let qrFeatures = dector.features(in: decodeImage) as? [CIQRCodeFeature]
        {
            return qrFeatures.count > 0
        }
        return false
    }
}
