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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupViewModel() {
//        guard let model = viewModel else { return }
        viewModel?.categoryValueClickedCompletion = { (category, selectedValue) in
            
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
