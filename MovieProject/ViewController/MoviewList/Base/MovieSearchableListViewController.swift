//
//  MovieSearchableListViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 09/08/21.
//

import UIKit

class MovieSearchableListViewController: BaseViewController {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var baseViewModel: MovieSearchableListViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Movie"
        // Do any additional setup after loading the view.
        setupViewModel()
        setupUI()
    }
    
    func setupViewModel() {
        
        // set tableview reload
        self.baseViewModel?.reloadTableCompletion = { shouldReload in
            DispatchQueue.main.async {
                guard shouldReload else { return }
                self.tableview.reloadData()
            }
        }
        
        // after clicking on movie cell push to movie details cell
        self.baseViewModel?.movieClickedCompletion = { movie in
            DispatchQueue.main.async {
                guard let vc: MovieDetailsViewController = self.getViewController(from: .main) else { return }
                let detailsViewModel = MovieDetailsViewModel(movie: movie)
                vc.viewModel = detailsViewModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        // initiate
        self.baseViewModel?.initiate()
    }
    
    public func setupTableViewCell() {
        // register movie cell for search
        let nibName = String(describing: MovieTableViewCell.self)
        let identifier = nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: identifier)
    }
    
    //MARK: Private methods
    
    private func setupUI() {
            
        // setup tableview
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.tableFooterView = UIView(frame: .zero)
        
        //setup searchBar
        self.searchBar.delegate = self
        // set delegate in textField in order to get action when clear button pressed
        searchBar.searchTextField.delegate = self

        self.setupTableViewCell()
        
    }

}

//MARK: UITableViewDataSource, UITableViewDelegate

extension MovieSearchableListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseViewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // return movie cell for search
        guard let cell: MovieTableViewCell = self.getTableViewCell(from: tableView),
              let model: VideoModel = self.baseViewModel?.getCellModel(for: indexPath) else {
            fatalError("")
        }
        cell.populate(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.baseViewModel?.tableViewDidTap(at: indexPath)
    }
    
    /// Get UITableViewCell from identifier
    /// - Parameters:
    ///   - tableView: tableview
    ///   - identifier: identifier
    /// - Returns: <#description#>
    final func getTableViewCell<T: UITableViewCell>(from tableView: UITableView, with identifier: String? = nil) -> T? {
        let value = identifier ?? String(describing: T.self)
        return tableview.dequeueReusableCell(withIdentifier: value) as? T
    }
}

//MARK: UISearchBarDelegate

extension MovieSearchableListViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // show cancel button
        searchBar.setShowsCancelButton(true, animated: true)
        self.baseViewModel?.searchBarBeginEditing()
        return true
    }
    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        searchBar.setShowsCancelButton(false, animated: true)
//        self.baseViewModel?.searchBarEndEditing()
//        return true
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // hide cancel button
        searchBar.setShowsCancelButton(false, animated: true)
        self.baseViewModel?.searchBarEndEditing()
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.resignFirstResponder()
        searchBar.text = nil
        self.baseViewModel?.searchBarEndEditing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // cancel previous request
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchFromMovies(text:)), object: nil)
        self.perform(#selector(self.searchFromMovies(text:)), with: searchText, afterDelay: 0.5)
    }
    
    @objc func searchFromMovies(text: String) {
        // search iff text character count greater equal to 3
        guard !text.isEmpty, text.count > 2 else { return }
        self.baseViewModel?.searchMovies(with: text)
    }
}

//MARK: UITextFieldDelegate

extension MovieSearchableListViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.perform(#selector(searchBarCancelButtonClicked(_:)), with: self.searchBar, afterDelay: 0.1)
        return true
    }
}
