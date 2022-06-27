//
//  MovieDetailsVC.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var movieDetailsTV: UITableView!

    // MARK: - Props

    private lazy var detailsItems = DetailsItems.allCases
    private var movieDetails: MovieResult?

    var movieId: Int?

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
    }

    // MARK: - UI Functions
    private func setupTV() {
        movieDetailsTV.delegate = self
        movieDetailsTV.dataSource = self

        movieDetailsTV.register(UINib(nibName: "MovieDescCell", bundle: nil), forCellReuseIdentifier: "MovieDescCell")
        movieDetailsTV.register(UINib(nibName: "TitleTVCell", bundle: nil), forCellReuseIdentifier: "TitleTVCell")
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
extension MovieDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTVCell") as? MovieTVCell {
            switch detailsItems[indexPath.row] {
            case .description:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescCell") as? MovieDescCell {
                    return cell
                }

            case .reddit, .website:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTVCell") as? TitleTVCell {
                    cell.titleLbl.text = detailsItems[indexPath.row].rawValue
                    return cell
                }

            }
            return cell
        }
        return UITableViewCell()
    }

}

extension MovieDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch detailsItems[indexPath.row] {
        case .description:
            return 142
        case .website, .reddit:
            return 54
        }
    }
}

enum DetailsItems: String, CaseIterable {
    case description
    case reddit = "Visit Reddit"
    case website = "Visit Website"
}
