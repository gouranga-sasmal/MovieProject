//
//  CellTitleTableViewCell.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import UIKit

class CellTitleTableViewCell: UITableViewCell, TableViewCellPopulatable {
    
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
