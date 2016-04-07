//
//  RepoSonucViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 13.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class RepoSonucViewController: UIViewController {
    
    
    @IBOutlet var repowebview: UIWebView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            let repourl = KeychainSwift.get("repo_urls")
            
            let url = NSURL (string: repourl! );
            
            let requestObj = NSURLRequest(URL: url!);
            
            repowebview.loadRequest(requestObj);
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}