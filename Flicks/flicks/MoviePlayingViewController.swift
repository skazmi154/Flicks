

import UIKit
import WebKit

class MoviePlayingViewController: UIViewController {
    
    var webUrl:String!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string:webUrl)!
        let request = URLRequest(url:url)
        self.webView.load(request)
    }
  
    
}
