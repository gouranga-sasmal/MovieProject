//
//  MovieDetailsViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import UIKit

/// Movie Details
class MovieDetailsViewController: BaseViewController {
    
    @IBOutlet var imageViewPoster: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPlot: UILabel!
    @IBOutlet var lblCastCrew: UILabel!
    @IBOutlet var lblReleaseDate: UILabel!
    @IBOutlet var lblGenre: UILabel!
    
    @IBOutlet var lblRating1: UILabel!
    @IBOutlet var ratingView1: RatingView!
    
    @IBOutlet var lblRating2: UILabel!
    @IBOutlet var ratingView2: RatingView!
    
    @IBOutlet var lblRating3: UILabel!
    @IBOutlet var ratingView3: RatingView!

    
    var viewModel: MovieDetailsViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movie Details"

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
        
        //TODO: Rating needs to dynamic For its can show only 3 ratings
        // show rating
        if viewModel.showRating() {
            let firstRating = viewModel.canShowRating(at: 0)
            
            
            if firstRating.show {
                // show first rating
                self.lblRating1.text = firstRating.ratingString
                self.ratingView1.currentRating = firstRating.rating
                
                // check if second rating can be shown or not
                let secondRating = viewModel.canShowRating(at: 1)
                
                if secondRating.show {
                    self.lblRating2.text = secondRating.ratingString
                    self.ratingView2.currentRating = secondRating.rating
                    
                    // check if third rating can be shown or not
                    let thirdRating = viewModel.canShowRating(at: 2)
                    
                    if thirdRating.show {
                        self.lblRating3.text = thirdRating.ratingString
                        self.ratingView3.currentRating = thirdRating.rating
                    } else {
                        //hide third recording
                        self.lblRating3.isHidden = true
                        self.ratingView3.isHidden = true
                    }
                    
                } else {
                    //hide second recording
                    self.lblRating2.isHidden = true
                    self.ratingView2.isHidden = true
                    
                    //hide third recording
                    self.lblRating3.isHidden = true
                    self.ratingView3.isHidden = true
                }
                
            } else {
                //hide whole rating recording
                self.lblRating1.superview?.isHidden = true
            }
        } else {
            // no rating is there. Hide rating view
            self.lblRating1.superview?.isHidden = true
        }
        
    }

}
