//
//  Extensions.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 18/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
