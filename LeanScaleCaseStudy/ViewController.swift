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
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }

}

// MARK: - Extensions
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTVCell") as? MovieTVCell {
            return cell
        }
        return UITableViewCell()
    }

}

extension ViewController: UITableViewDelegate {

}
