
import UIKit

import AlamofireImage


class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var movies:[[String:Any]] = []
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityIndicator.startAnimating()
        
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableview.rowHeight = 250

        tableview.insertSubview(refreshControl, at:0)
        tableview.dataSource = self

           fetchNowPlaying()
        
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        
        fetchNowPlaying()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableview.indexPath(for: cell)
        let movie = movies[(indexPath?.row)!]
        let id = movie["id"] as! Int
        
      
        let detailView = segue.destination as! DetailViewController
        detailView.movie = movie
        detailView.id = id
    }
    
    
    func fetchNowPlaying () {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=3ca4232e03c4d16ac675e3a84a6128ad")!
        
        let request = URLRequest(url:url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) {
            
            (data, response, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
                
            else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String:Any]]
                
                
                self.movies = movies
                
                self.tableview.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableview.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        let title = movie["title"] as! String
        
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text = title
        
        cell.overviewLabel.text = overview
        
        let posterPath = movie["poster_path"] as! String
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        let url = URL(string: baseURL + posterPath)!
        
        cell.posterImage.af_setImage(withURL: url)
        
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    

    

}
