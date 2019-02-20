//
//  MoviePlayerViewController.swift
//  flix
//
//  Created by Sandesh Basnet on 2/19/19.
//  Copyright © 2019 Sandesh Basnet. All rights reserved.
//

import UIKit
import WebKit

class MoviePlayerViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    
    
    var webUrl:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string:webUrl)!
        let request = URLRequest(url:url)
        webView.load(request)
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "backButton", sender: nil)
        
    }
    

   

}
