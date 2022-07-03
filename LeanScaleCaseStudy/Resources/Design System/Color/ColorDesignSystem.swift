//
//  ColorDesignSystem.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 26/07/2021.
//

import UIKit
import Foundation

enum AppColors: String {
    case selectedCell = "#E0E0E0"
    
    var color:UIColor {
        return UIColor(hex: self.rawValue)
    }
    
    var CGColor:CGColor {
        return UIColor(hex: self.rawValue).cgColor
    }
    
}

extension UIColor {
    convenience init(hex:String, alpha: Int = 1) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(white: 0, alpha: 1)
            return
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string:cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
}
