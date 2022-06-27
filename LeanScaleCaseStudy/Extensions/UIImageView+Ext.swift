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
