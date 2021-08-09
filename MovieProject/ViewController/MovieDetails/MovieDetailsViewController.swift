//
//  MovieDetailsViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    @IBOutlet var imageViewPoster: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPlot: UILabel!
    @IBOutlet var lblCastCrew: UILabel!
    @IBOutlet var lblReleaseDate: UILabel!
    @IBOutlet var lblGenre: UILabel!
    @IBOutlet var lblRating: UILabel!

    
    var viewModel: MovieDetailsViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let model = self.viewModel else {
            return
        }
        
        self.setupUI(with: model)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// Setup the information in UI
    /// - Parameter viewModel: <#viewModel description#>
    private func setupUI(with viewModel: MovieDetailsViewModel) {
        self.imageViewPoster.setPoster(viewModel.getPosterURL())
        self.lblTitle.text = viewModel.getMoviewTitle()
        self.lblPlot.text = viewModel.getPlot()
        self.lblCastCrew.text = viewModel.getCastAndCrew()
        self.lblReleaseDate.text = viewModel.getReleaseDate()
        self.lblGenre.text = viewModel.getGenre()
        self.lblRating.text = viewModel.getRating()
    }

}
