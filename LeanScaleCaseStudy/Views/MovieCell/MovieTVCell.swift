//
//  MovieTVCell.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import UIKit

class MovieTVCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieMeta: UILabel!
    @IBOutlet weak var movieGenre: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateMovieCell(movie: MovieResult) {
        movieImage.downloadImage(path: movie.backgroundImage)
        movieTitle.text = movie.name
        movieMeta.text = String(movie.metacritic ?? 0)
        movieGenre.text = getMovieGenres(genres: movie.genres)
    }

    private func getMovieGenres(genres: [Genre]) -> String {
        return genres
            .map {
                $0.name
            }
            .joined(separator: ", ")
    }
    
}
