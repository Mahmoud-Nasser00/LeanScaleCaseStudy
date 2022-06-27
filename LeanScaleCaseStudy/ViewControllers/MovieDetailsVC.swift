//
//  MovieDetailsVC.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var movieDetailsTV: UITableView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!

    // MARK: - Props

    private lazy var favoriteBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Favorite", for: .normal)
        btn.setTitle("Favorited", for: .selected)
        btn.addTarget(self, action: #selector(favoriteBtnTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var detailsItems = DetailsItems.allCases
    private var movieDetails: MovieDetails?

    var movieId: Int?

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTV()
        fetchMovieDetails(id: movieId)
    }

    // MARK: - UI Functions

    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteBtn)
    }

    private func setupTV() {
        movieDetailsTV.delegate = self
        movieDetailsTV.dataSource = self

        movieDetailsTV.register(UINib(nibName: "MovieDescCell", bundle: nil), forCellReuseIdentifier: "MovieDescCell")
        movieDetailsTV.register(UINib(nibName: "TitleTVCell", bundle: nil), forCellReuseIdentifier: "TitleTVCell")
    }

    private func updateTVHeader(movieDetails: MovieDetails) {
        movieImage.downloadImage(path: movieDetails.backgroundImage)
        movieName.text = movieDetails.name
    }

    private func fetchMovieDetails(id: Int?) {
        guard let id = id else { return }
        FetchMovieDetailsApi.shared.fetchMovieDetails(id: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                guard let model = model else { return }
                self.movieDetails = model
                self.updateTVHeader(movieDetails: model)
                self.movieDetailsTV.reloadData()
            case .failure(let error):
                guard let error = error.userInfo[NSLocalizedDescriptionKey] as? String else { return }
                print(error)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Actions
    @objc func favoriteBtnTapped(){
        favoriteBtn.isSelected = !favoriteBtn.isSelected
    }

}
// MARK: - Extensions
extension MovieDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescCell") as? MovieDescCell {
                cell.updateDesc(desc: movieDetails?.description ?? "")
                return cell
            }
        case 1, 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTVCell") as? TitleTVCell {
                cell.titleLbl.text = detailsItems[indexPath.row].rawValue
                return cell
            }
        default:
            return UITableViewCell()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch detailsItems[indexPath.row] {
        case .description:
            break
        case .reddit, .website:
            break
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

enum DetailsItems: String, CaseIterable {
    case description
    case reddit = "Visit Reddit"
    case website = "Visit Website"
}
