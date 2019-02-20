
import UIKit

import AlamofireImage

import AVFoundation

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var backGroundImage: UIImageView!
    
    
    @IBOutlet weak var posterImage: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    var id:Int!
    
    var trailerString = ""
    
    var movie: [String: Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.getMovieTrailerString()
        
        playButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        playButton.layer.cornerRadius = 0.5 * playButton.bounds.size.width
        playButton.clipsToBounds = true
       
        
        if let movie = self.movie {
            
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overViewLabel.text = movie["overview"] as? String
            let backgroundImagePath = movie["backdrop_path"] as! String
            let posterImagePath = movie["poster_path"] as! String
            
            let baseURL = "https://image.tmdb.org/t/p/w500"
            
            
            let background_url = URL(string: baseURL +  backgroundImagePath)!
            let poster_url = URL (string: baseURL + posterImagePath)!
            
            self.backGroundImage.af_setImage(withURL: background_url)
            self.posterImage.af_setImage(withURL: poster_url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovieTrailerString() {
        
        
        let url = URL(string:"http://api.themoviedb.org/3/movie/\(self.id!)/videos?api_key=3ca4232e03c4d16ac675e3a84a6128ad")!
        
        
        let request = URLRequest(url:url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) {
            
            (data, response, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
                
            else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                let trailers = dataDictionary["results"] as! [[String:Any]]
                
                
                let key = trailers[0]["key"] as! String
                self.trailerString = "https://www.youtube.com/watch?v="+key
               
            }
        }
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "trailerView" {
            
            let destination = segue.destination as! MoviePlayingViewController
            destination.webUrl = self.trailerString
            
        }
    }
    

    @IBAction func playButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "trailerView", sender: nil)
        
    
    }
    
}
