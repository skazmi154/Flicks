//
//  ViewController.swift
//  flicks
//
//  Created by Syed Kazmi on 2/6/19.
//  Copyright © 2019 Syed Kazmi. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts:[[String:Any]] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchData()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        let movie = posts[indexPath.row]
        let title = movie["title"] as! String
        let description = movie["overview"] as! String
        let url_path = movie["poster_path"] as! String
        let url = "https://image.tmdb.org/t/p/w185\(url_path)"
        cell.movieTitle.text = title
        cell.movieDescription.text = description
        let poster_url = URL(string: url)
        cell.moviePoster.af_setImage(withURL: poster_url!)
        return cell
    }
    
    func fetchData() {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
               let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                self.posts = dataDictionary["results"] as! [[String : Any]]
                self.tableView.reloadData()

                
             
                
            }
        }
        task.resume()
    }
    
   
    


}

