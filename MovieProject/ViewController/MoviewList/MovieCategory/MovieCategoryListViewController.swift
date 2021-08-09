//
//  MovieCategoryListViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 09/08/21.
//

import Foundation
import UIKit

class MovieCategoryListViewController: MovieSearchableListViewController {

    override func setupViewModel() {
        ///initiate viewModel for this controller
        let viewModel = MovieCategoryListViewModel()
        viewModel.tableClickedCompletion = { (category, movies) in
            // after clcked on tableview push to category result controller
            let vc: MovieCategoryValuesViewController = self.getViewController(subClassOf: MovieSearchableListViewController.self)
            
            //initiate viewmodel for category result controller with category adn movie
            let vModel = MovieCategoryValuesViewModel(category: category, and: movies)
            vc.viewModel = vModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //assign viewModel
        self.baseViewModel = viewModel
        //call super. NOTE: Befor call super assign viewMdoel to baseViewModel
        super.setupViewModel()
    }

    
    override func setupTableViewCell() {
        super.setupTableViewCell()
        let nibName = String(describing: MovieCategoryTitleTableViewCell.self)
        let identifier = nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: identifier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard self.baseViewModel?.searchMode == .off else {
            // if search on the n show movie cell
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        // if search off then show this tableviewCell
        guard let cell: MovieCategoryTitleTableViewCell = self.getTableViewCell(from: tableView),
              let model: String = self.baseViewModel?.getCellModel(for: indexPath) else {
            fatalError("")
        }
              
        cell.populate(model)
        return cell
    }
    
}
