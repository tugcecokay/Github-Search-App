//
//  IssueSonuc.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 31.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//


import UIKit

class IssueSonucViewController: UIViewController {
    
    
    @IBOutlet weak var issuewebview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let repourl = KeychainSwift.get("issue_urls")
        
        let url = NSURL (string: repourl! );
        
        let requestObj = NSURLRequest(URL: url!);
        
        issuewebview.loadRequest(requestObj);
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
