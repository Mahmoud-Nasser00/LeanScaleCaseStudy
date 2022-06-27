//
//  ViewController.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 26/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviesTV: UITableView!
    // MARK: - props
    private var moviesList = [MovieResult]()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        fetchMovies(page: 1)
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
                self.moviesList = model?.results ?? []
                self.moviesTV.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

// MARK: - Extensions
extension ViewController: UITableViewDataSource {
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
