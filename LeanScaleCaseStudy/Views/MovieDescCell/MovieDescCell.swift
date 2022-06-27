//
//  MovieDescCell.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import UIKit

class MovieDescCell: UITableViewCell {

    @IBOutlet weak var movieDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateDesc(desc: String) {
        movieDesc.attributedText = desc.htmlToAttributedString
    }
    
}
