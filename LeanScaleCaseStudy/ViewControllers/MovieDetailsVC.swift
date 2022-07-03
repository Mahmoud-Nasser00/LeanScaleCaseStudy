//
//  MovieDetailsVC.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

// MARK: - Doc
// i choose to make movie details in UIViewController for future updated to be easily managed and reusable
// best part i worked on is see less and see more in details

import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var movieDetailsTV: UITableView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!

    // MARK: - Props

    private lazy var favoriteBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemBlue, for: .normal)
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
        favoriteBtn.isSelected = movieDetails?.isFavorite ?? false
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

    private func openUrl(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
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
    @objc func favoriteBtnTapped() {
        favoriteBtn.isSelected = !favoriteBtn.isSelected
        movieDetails?.isFavorite = favoriteBtn.isSelected
        if favoriteBtn.isSelected {
            guard let movieDetails = movieDetails else {
                return
            }

            let movie = Movie(id: movieDetails.id,
                              name: movieDetails.name,
                              backgroundImage: movieDetails.backgroundImage,
                              metacritic: movieDetails.metacritic ?? 0,
                              genres: movieDetails.genres.map { $0.name }.joined(separator: ", "),
                              isOpened: false,
                              isFavorite: true)

            CoreDataServices.instance.saveMovieToCoraData(movie: movie, completion: nil)
        }
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
                cell.selectionDelegate = self
                // InCase of html
//                cell.updateDesc(desc: movieDetails?.description ?? "")

                // in case if raw string
                cell.updateDesc(desc: movieDetails?.descriptionRaw ?? "")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch detailsItems[indexPath.row] {
        case .description:
            if let cell = tableView.cellForRow(at: indexPath) as? MovieDescCell {
                cell.isMore = !cell.isMore
            }
        case .reddit:
            openUrl(urlString: movieDetails?.redditUrl ?? "")
            tableView.deselectRow(at: indexPath, animated: true)
        case .website:
            openUrl(urlString: movieDetails?.website ?? "")
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

enum DetailsItems: String, CaseIterable {
    case description
    case reddit = "Visit Reddit"
    case website = "Visit Website"
}

extension MovieDetailsVC: CellSelectionDelegate {
    func cellSelected(isSelected: Bool, cell: UITableViewCell) {
        movieDetailsTV.beginUpdates()
        (cell as? MovieDescCell)?.movieDescLbl.seeMoreLessText(isLess: isSelected, text: movieDetails?.descriptionRaw ?? "")
        movieDetailsTV.endUpdates()
    }
}
