//
//  UsersSonucViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 18.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class UsersSonucViewController: UIViewController {
    
    @IBOutlet var uwebview: UIWebView!
    var waitingView  = WaitingView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       kullanici_detaylari()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func kullanici_detaylari(){
        waitingView  = WaitingView(frame : self.view.bounds)
        self.view.addSubview(waitingView)
        
        let k_url = KeychainSwift.get("kullanici_urls")
        
        let url = NSURL (string: k_url! );
        
        let requestObj = NSURLRequest(URL: url!);

        
        dispatch_async(dispatch_get_main_queue()){
        self.waitingView.removeFromSuperview()
        
        self.uwebview.loadRequest(requestObj);
        }
        
    }
}