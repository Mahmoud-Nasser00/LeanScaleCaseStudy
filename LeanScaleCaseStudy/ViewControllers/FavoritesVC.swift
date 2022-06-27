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
    private var favoritesList = [MovieResult]()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - UI Functions
    private func setupTV() {
        favoritesTV.delegate = self
        favoritesTV.dataSource = self

        favoritesTV.register(UINib(nibName: "MovieTVCell", bundle: nil), forCellReuseIdentifier: "MovieTVCell")
    }

    private func handleEmptyState(favs: [MovieResult]) {
        favoritesTV.tableFooterView?.isHidden = favs.count == 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
}
