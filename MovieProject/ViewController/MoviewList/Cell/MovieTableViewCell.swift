//
//  MovieTableViewCell.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import UIKit
import SDWebImage

protocol TableViewCellPopulatable {
    associatedtype modeltype
    func populate(_ model: modeltype)
}

class MovieTableViewCell: UITableViewCell, TableViewCellPopulatable  {
    
    typealias modeltype = VideoModel
    
    @IBOutlet var imagePoster: UIImageView!
    @IBOutlet var lblMovieTitle: UILabel!
    @IBOutlet var lblLanguages: UILabel!
    @IBOutlet var lblYear: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(_ model: VideoModel) {
        lblMovieTitle.text = model.title
        lblLanguages.text = model.language
        lblYear.text = model.year
        self.imagePoster.setPoster(model.poster)
    }
    
}
