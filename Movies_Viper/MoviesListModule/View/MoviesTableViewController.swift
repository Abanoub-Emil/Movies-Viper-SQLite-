//
//  MoviesTableViewController.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesTableViewController: UITableViewController {
    
    var presenter: MovieListPresenterProtocol?
    var allMovies = [Movie]()
    let sharedDBManager = SQLiteManager.sqliteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.getCachedMovies()
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allMovies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = allMovies[indexPath.row].title
        cell.imageView?.sd_setImage(with: URL(string: allMovies[indexPath.row].image), placeholderImage: UIImage(named: "record1"))
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToDetailScreen(movie: allMovies[indexPath.row], navigationController: navigationController!)
    }


}


extension MoviesTableViewController: MovieListViewProtocol {
    
    func showMovies(movies: [Movie]) {
        allMovies = movies
        tableView.reloadData()
    }
    
    func showError(errorMsg: String) {
        print(errorMsg)
    }
}
