//
//  UIImageView+Ext.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import Foundation
import SDWebImage
import UIKit

extension UIImageView {
    func downloadImage(path : String, placeHolder: String? = nil) {
        if let url = URL(string: path) {
            if placeHolder != nil {
                self.sd_setImage(with: url, placeholderImage: UIImage(named: placeHolder!) , completed: nil)
            } else {
                self.sd_setImage(with: url, completed: nil)
            }

        }
    }
}

extension UILabel {
    func seeMoreLessText(isLess: Bool, text: String) {
        let seeMoreOrLess = isLess ? "...see more": "   see less"
        var allString = text as NSString
        if allString.length >= 150 {
            if isLess {
                allString = allString.substring(with: NSRange(location: 0, length: allString.length > 150 ? 150 : allString.length)) as NSString
            }
            let handledAllString = allString as String + seeMoreOrLess as NSString
            let finalHandledAllString = NSMutableAttributedString(string: handledAllString as String)
            let rangeSeeMoreHandled = handledAllString.range(of: seeMoreOrLess, options: .regularExpression, range: NSMakeRange(0, handledAllString.length))
            if rangeSeeMoreHandled.length > 0 {
                finalHandledAllString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: rangeSeeMoreHandled)
            }
            self.attributedText = finalHandledAllString
        }

    }
}

extension UITableViewCell {
    func animateSwipeAnimation(row: Int) {
        let delay = -70 * Double(row)
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, delay, 0, 0)
        layer.transform = rotationTransform

        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.layer.transform = CATransform3DIdentity
        }
    }

}
