//
//  ViewController.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit
import HCSStarRatingView
import SDWebImage

class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol?
    var movie = Movie()

    
    @IBOutlet weak var movieImage: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var hcsStarRating: HCSStarRatingView!
    @IBOutlet weak var movieOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hcsStarRating.isUserInteractionEnabled = false
        hcsStarRating.value = 6.7
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        movieTitle.text = movie.title
        SDWebImageManager.shared().loadImage(
            with: URL(string: movie.image),
            options: .highPriority,
            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                self.movieImage.setBackgroundImage(image, for: .normal)
        }
        movieOverview.text = movie.overview
        hcsStarRating.value = movie.vote_average!
    }
    
    @IBAction func openMovieTrailer(_ sender: UIButton) {
        let URL = movie.preVideoURL + movie.id! + movie.postVideoURL
        presenter!.getVideoKey(url: URL)

    }
}

extension DetailViewController: DetailViewProtocol {
    
    func openTrailerVideo(url: String) {
        UIApplication.shared.open(NSURL(string: url)! as URL)

    }
    
    
    
}
