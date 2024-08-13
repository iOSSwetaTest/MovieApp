//
//  HomeViewController.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-12.
//

import Foundation
import UIKit

enum ViewState {
    case loading
    case error(message: String)
    case dataLoaded
}

class HomeViewController: UIViewController {
    let tableView = UITableView()
    var movieList : [Movie] = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Home"
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let list = MockJson.fetchMovieList()?.results else { return }
        movieList = list
        tableView.reloadData()
        
        
        guard Reachability.isConnectedToNetwork() else {
            showAlert()
            return
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Alert!", message: Strings.noInternet, preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(defaultButton)
        present(alert, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
   
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
      cell.movie =  movieList[indexPath.row]
      return cell
  }
    
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailVC = DetailViewController()
        DetailVC.movieName = movieList[indexPath.row].name
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }

}
