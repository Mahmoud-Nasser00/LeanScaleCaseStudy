//
//  MovieDescCell.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import UIKit

protocol CellSelectionDelegate: AnyObject {
    func cellSelected(isSelected: Bool, cell: UITableViewCell)
}

class MovieDescCell: UITableViewCell {

    @IBOutlet weak var movieDescLbl: UILabel!

    var isMore: Bool = true
    weak var selectionDelegate: CellSelectionDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieDescLbl.numberOfLines = 0
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionDelegate?.cellSelected(isSelected: isMore, cell: self)
    }

    func updateDesc(desc: String) {
        movieDescLbl.seeMoreLessText(isLess: isMore, text: desc)

        // in case of html string
        // movieDescLbl.attributedText = attributedText
    }
    
}
