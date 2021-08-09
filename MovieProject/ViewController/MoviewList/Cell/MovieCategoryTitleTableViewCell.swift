//
//  MovieCategoryTitleTableViewCell.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 09/08/21.
//

import UIKit

class MovieCategoryTitleTableViewCell: UITableViewCell, TableViewCellPopulatable {
    
    typealias modeltype = String
    
    @IBOutlet var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(_ model: String) {
        self.lblTitle.text = model
    }
    
}
