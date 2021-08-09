//
//  MovieCategoryValuesViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 09/08/21.
//

import Foundation
import UIKit

class MovieCategoryValuesViewController: MovieSearchableListViewController {
    
    var viewModel: MovieCategoryValuesViewModel? = nil
    
    override func setupViewModel() {
        
        viewModel?.categoryValueClickedCompletion = { (category, selectedValue, movies) in
            // after clcked on tableview push to movie list controller
            let vc: MovieListViewController = self.getViewController(subClassOf: MovieSearchableListViewController.self)
            let vModel = MovieListViewModel(category: category, value: selectedValue, and: movies)
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
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        
        guard let cell: MovieCategoryTitleTableViewCell = self.getTableViewCell(from: tableView),
              let model: String = self.baseViewModel?.getCellModel(for: indexPath) else {
            fatalError("")
        }
              
        cell.populate(model)
        return cell
    }
    
}
