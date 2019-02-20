

import UIKit

import AlamofireImage

class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        fetchData()
        self.collectionView.dataSource = self
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.movies.count
    }

    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let movie = self.movies[indexPath.item]
        
        if let posterPath = movie["poster_path"] as? String {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            
            let url = URL(string: baseURL + posterPath)!
            
            cell.posterImage.af_setImage(withURL: url)
            
        }
        return cell
    }
    
    func fetchData () {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=3ca4232e03c4d16ac675e3a84a6128ad&language=en-US&page=1")!
        
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
                self.collectionView.reloadData()
               // self.refreshControl.endRefreshing()
            }
        }
        
        task.resume()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
