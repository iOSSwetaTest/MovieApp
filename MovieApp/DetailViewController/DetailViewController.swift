//
//  DetailViewController.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-13.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
  
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    let moviePosterImageView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "PlaceHolderImage"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let movieOverviewLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Movie OverView"
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let movieSynopsisLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let horizotalScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    var movieName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(scrollView)
        
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(moviePosterImageView)
        
        movieOverviewLbl.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(movieOverviewLbl)
        
        movieSynopsisLbl.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(movieSynopsisLbl)
        
        horizotalScrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(horizotalScrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             
            moviePosterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            moviePosterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moviePosterImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            moviePosterImageView.heightAnchor.constraint(equalTo: moviePosterImageView.widthAnchor),
            
            movieOverviewLbl.topAnchor.constraint(equalTo: moviePosterImageView.lastBaselineAnchor, constant: 16),
            movieOverviewLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
           
            movieSynopsisLbl.topAnchor.constraint(equalTo: movieOverviewLbl.lastBaselineAnchor, constant: 16),
            movieSynopsisLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            movieSynopsisLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            
            horizotalScrollView.topAnchor.constraint(equalTo: movieSynopsisLbl.lastBaselineAnchor, constant: 16),
            horizotalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            horizotalScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            horizotalScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            horizotalScrollView.heightAnchor.constraint(equalToConstant: 130)

        ])

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = MockJson.getMovieDetails(accountId: 10) else { return }
        title = movieName
        movieSynopsisLbl.text = detail.overview
        
        guard let posterPath = detail.poster_path else {
            moviePosterImageView.image = UIImage(named: "PlaceHolderImage")
            return
        }
        
        moviePosterImageView.imageFromServerURL(urlString:  "http://image.tmdb.org/t/p/w500\(posterPath)", PlaceHolderImage: UIImage.init(named: "PlaceHolderImage")!)
        
        self.displaySimilarMovies()
    }
    
    func displaySimilarMovies() {
        guard let similarMovieList = MockJson.fetchSimilarMovieList() else { return }
        let numberOfPages :Int = similarMovieList.results.count
        let padding : CGFloat = 15
        let viewWidth = 100
        let viewHeight = 100

        var x : CGFloat = 0

        for movie in similarMovieList.results {
            
            let view: UIView = UIView(frame: CGRect(x: x + padding, y: padding, width: CGFloat(viewWidth), height: CGFloat(viewHeight)))
            horizotalScrollView.addSubview(view)
            x = view.frame.origin.x + 100

            let posterImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            posterImage.contentMode = .scaleAspectFit
            posterImage.layer.masksToBounds = true
            posterImage.layer.borderWidth = 1.5
            posterImage.layer.borderColor = UIColor.black.cgColor
            posterImage.layer.cornerRadius = 2
            view.addSubview(posterImage)
            
            guard let posterPath = movie.poster_path else {
                posterImage.image = UIImage(named: "PlaceHolderImage")
                continue
            }
           posterImage.imageFromServerURL(urlString:  "http://image.tmdb.org/t/p/w92\(posterPath)", PlaceHolderImage: UIImage.init(named: "PlaceHolderImage")!)

        }
        horizotalScrollView.contentSize = CGSize(width: 122 * numberOfPages, height: 130)
    }
}
