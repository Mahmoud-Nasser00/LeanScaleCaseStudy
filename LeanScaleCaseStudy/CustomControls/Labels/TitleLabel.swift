//
//  TitleLabel.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import UIKit

class TitleLabel: UILabel {

    @IBInspectable var fontSize: CGFloat = 18 {
        didSet {
            font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupFont()
        setAlignment()
    }

    private func setupFont() {
        font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    private func setAlignment() {
        if let language = NSLocale.preferredLanguages.first {
            textAlignment = language.contains("ar") ? .right : .left
        }
    }

}
