//
//  CoreDataManager.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 28/06/2022.
//

import CoreData
import UIKit

class CoreDataServices {

    static let instance = CoreDataServices()

    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    private init() { }

    func removeItemFromCoreData(atRow row: Int, arrayOfData: [AnyObject]) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext
        else { return }
        managedContext.delete(arrayOfData[row] as? NSManagedObject ?? NSManagedObject())
        do {
            try managedContext.save()
        } catch {
            debugPrint("couldn't remove\(error)")
            print("successfully removed")
        }
    }

    func saveMovieToCoraData(movie: Movie, completion: ((_ completed: Bool ) -> Void)?) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return } // get the managed context
        let movieCD = MovieCD(context: managedContext)// instance of FeaturedItemCD Entity and Pass the context to know where to save the data
        movieCD.movieName = movie.name
        movieCD.movieImage = movie.backgroundImage
        movieCD.movieMeta = String(movie.metacritic)
        movieCD.movieGenres = movie.genres
        movieCD.isOpened = movie.isOpened
        movieCD.isFavorite = movie.isFavorite

        do {
            try managedContext.save() // because this is a throw it has to be done in do catch
            print("success")
            completion?(true) // this means the save has been done correctly
        } catch {
            debugPrint("could not save\(error.localizedDescription)")
            completion?(false) // this means the save hasn't been done correctly
        }
    }

    func fetchItems(completion:(_ movies: [MovieCD]) -> Void ) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext
        else {
            completion([])
            return
        }
        let fetchCartRequest = NSFetchRequest<MovieCD>(entityName: "MovieCD")
        do {
            let movies = try managedContext.fetch(fetchCartRequest)
            completion(movies)
        } catch {
            debugPrint("couldn't fetch\(error.localizedDescription)")
            completion([])
        }
    }

}
