//
//  KodSonucViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 18.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class KodSonucViewController: UIViewController {
    
    @IBOutlet var kodview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let dosya_url = KeychainSwift.get("dosya_urls")
        
        let url = NSURL (string: dosya_url! );
        
        let requestObj = NSURLRequest(URL: url!);
        
        kodview.loadRequest(requestObj);
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}