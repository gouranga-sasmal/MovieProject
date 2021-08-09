//
//  MovieCategoryListViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 09/08/21.
//

import Foundation
import UIKit

class MovieCategoryListViewController: MovieSearchableListViewController {
    
//    var viewModel = MovieCategoryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Movie"
        
    }
    
    override func setupViewModel() {
        let viewModel = MovieCategoryListViewModel()
        viewModel.tableClickedCompletion = { (category, movies) in
            let vc: MovieCategoryValuesViewController = self.getViewController(subClassOf: MovieSearchableListViewController.self)
            let vModel = MovieCategoryValuesViewModel(category: category, and: movies)
            vc.viewModel = vModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.baseViewModel = viewModel
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
