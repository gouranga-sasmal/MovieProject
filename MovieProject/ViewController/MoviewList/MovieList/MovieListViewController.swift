//
//  MovieListViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import UIKit

class MovieListViewController: MovieSearchableListViewController {

    var viewModel: MovieListViewModel? = nil

    override func setupViewModel() {
        self.baseViewModel = viewModel
        super.setupViewModel()
    }
}
