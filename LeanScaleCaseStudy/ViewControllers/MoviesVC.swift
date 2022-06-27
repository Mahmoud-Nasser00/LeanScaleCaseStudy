//
//  ViewController.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 26/06/2022.
//

import UIKit

class MoviesVC: UIViewController {

    @IBOutlet weak var moviesTV: UITableView!

    // MARK: - props
    private var moviesList = [MovieResult]()
    private var totalCount: Int = 0
    private var currentPage: Int = 1

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        fetchMovies(page: currentPage)
    }

    // MARK: - UI Functions
    private func setupTV() {
        moviesTV.delegate = self
        moviesTV.dataSource = self

        moviesTV.register(UINib(nibName: "MovieTVCell", bundle: nil), forCellReuseIdentifier: "MovieTVCell")
    }

    // MARK: - Functions
    private func fetchMovies(page: Int) {
        FetchMoviesApi.shared.fetchMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.totalCount = model?.count ?? 0
                if page == 1 {
                    self.moviesList = model?.results ?? []
                } else {
                    self.moviesList.append(contentsOf: model?.results ?? [])
                }
                self.moviesTV.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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
extension MoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTVCell") as? MovieTVCell {
            cell.updateMovieCell(movie: moviesList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}

extension MoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == moviesList.count - 1 && totalCount != moviesList.count {
            currentPage += 1
            fetchMovies(page: currentPage)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = moviesList[indexPath.row].id
        pushToMovieDetailsVC(movieId: movieId)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
