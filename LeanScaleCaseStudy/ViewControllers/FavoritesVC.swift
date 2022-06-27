//
//  FavoritesVC.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var favoritesTV: UITableView!

    // MARK: - props
    private let searchController = UISearchController()
    private var favoritesList = [MovieResult]()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
    }

    // MARK: - UI Functions

    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }

    private func setupTV() {
        favoritesTV.delegate = self
        favoritesTV.dataSource = self

        favoritesTV.register(UINib(nibName: "MovieTVCell", bundle: nil), forCellReuseIdentifier: "MovieTVCell")
    }

    private func handleEmptyState(favs: [MovieResult]) {
        favoritesTV.tableFooterView?.isHidden = favs.isEmpty
    }

    // MARK: - Navigation
    private func pushToMovieDetailsVC(movieId id: Int) {
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsVC {
            detailsVC.movieId = id
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }

}

// MARK: - Extensions
extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTVCell") as? MovieTVCell {
            cell.updateMovieCell(movie: favoritesList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = favoritesList[indexPath.row].id
        pushToMovieDetailsVC(movieId: movieId)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoritesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
