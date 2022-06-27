//
//  ViewController.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 26/06/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies(page: 1)
    }

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
