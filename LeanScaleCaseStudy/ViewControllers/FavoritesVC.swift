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
    private var favoritesList = [MovieCD]()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
        fetchFavMovie()
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

    private func fetchFavMovie() {
        CoreDataServices.instance.fetchItems { [weak self] movies in
            self?.favoritesList = movies
            handleEmptyState(favs: movies)
            self?.favoritesTV.reloadData()
        }
    }

    private func handleEmptyState(favs: [MovieCD]) {
        favoritesTV.tableFooterView?.isHidden = !favs.isEmpty
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
            cell.updateFavoriteCell(movie: favoritesList[indexPath.row])
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
        pushToMovieDetailsVC(movieId: Int(movieId))
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataServices.instance.removeItemFromCoreData(atRow: indexPath.row, arrayOfData: favoritesList)
            favoritesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            handleEmptyState(favs: favoritesList)
        }
    }
}

extension FavoritesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
