//
//  MovieListViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var viewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup(self.viewModel)
        setupUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// Setup viewModel
    /// - Parameter model: <#model description#>
    private func setup(_ model: MovieListViewModel) {
        
        model.reloadTableCompletion = { shouldReload in
            DispatchQueue.main.async {
                guard shouldReload else { return }
                self.tableview.reloadData()
            }
        }
        
        model.movieClickedCompletion = { movie in
            DispatchQueue.main.async {
                guard let vc: MovieDetailsViewController = self.getViewController(from: .main) else { return }
                let detailsViewModel = MovieDetailsViewModel(movie: movie)
                vc.viewModel = detailsViewModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        model.initiate()
    }
    
    /// SetupUI
    private func setupUI() {
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.tableFooterView = UIView(frame: .zero)
        
        let nibName = String(describing: MovieTableViewCell.self)
        let identifier = nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: identifier)
        
        self.searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }

}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.viewModel.showMovieList() {
            let cell: MovieTableViewCell? = self.getTableViewCell(from: tableView)
            cell?.populate(self.viewModel.getCellModel(for: indexPath))
            return cell!
        } else {
            let cell: CellTitleTableViewCell? = self.getTableViewCell(from: tableView)
            cell?.populate(self.viewModel.getCellModel(for: indexPath))
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.tableViewDidTap(at: indexPath)
    }
    
    /// Get UITableViewCell from identifier
    /// - Parameters:
    ///   - tableView: tableview
    ///   - identifier: identifier
    /// - Returns: <#description#>
    private func getTableViewCell<T: UITableViewCell>(from tableView: UITableView, with identifier: String? = nil) -> T? {
        let value = identifier ?? String(describing: T.self)
        return tableview.dequeueReusableCell(withIdentifier: value) as? T
    }
}

//MARK: UISearchBarDelegate

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        self.viewModel.searchBarBeginEditing()
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        self.viewModel.searchBarEndEditing()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.resignFirstResponder()
        searchBar.text = nil
        self.viewModel.searchBarEndEditing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchFromMovies(text:)), object: nil)
        self.perform(#selector(self.searchFromMovies(text:)), with: searchText, afterDelay: 0.5)
    }
    
    @objc func searchFromMovies(text: String) {
        guard !text.isEmpty, text.count > 2 else { return }
        self.viewModel.searchMovies(with: text)
    }
}

//MARK: UITextFieldDelegate

extension MovieListViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.perform(#selector(searchBarCancelButtonClicked(_:)), with: self.searchBar, afterDelay: 0.1)
        return true
    }
}
