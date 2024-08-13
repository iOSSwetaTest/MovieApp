//
//  CustomCell.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-12.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        if self.image == nil{
              self.image = PlaceHolderImage
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}


class CustomCell : UITableViewCell {
    var movie : Movie? {
     didSet {
         movieTitleLabel.text = movie?.name
         
         guard let posterPath = self.movie?.poster_path else {
             self.movieThumbnailImageView.image = UIImage(named: "PlaceHolderImage")
             return
         }
        
         movieThumbnailImageView.imageFromServerURL(urlString:  "http://image.tmdb.org/t/p/w185\(posterPath)", PlaceHolderImage: UIImage.init(named: "PlaceHolderImage")!)
  
        }
     }
     
     
     private let movieTitleLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .black
     lbl.font = UIFont.boldSystemFont(ofSize: 16)
     lbl.textAlignment = .left
     return lbl
     }()
     
     private let movieThumbnailImageView : UIImageView = {
         let imgView = UIImageView(image: UIImage(named: "PlaceHolderImage"))
         imgView.contentMode = .scaleAspectFit
         imgView.clipsToBounds = true
         return imgView
     }()
     
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(movieTitleLabel)
         contentView.addSubview(movieThumbnailImageView)
   
        movieThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        movieThumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        movieThumbnailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        movieThumbnailImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        movieThumbnailImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true

        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieTitleLabel.leftAnchor.constraint(equalTo: movieThumbnailImageView.rightAnchor, constant: 10).isActive = true
        movieTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        movieTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
