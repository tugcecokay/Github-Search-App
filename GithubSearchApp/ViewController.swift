//
//  ViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 9.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var codeBtn: UIButton!
    
    @IBOutlet weak var issueBtn: UIButton!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var repoBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeBtn.layer.cornerRadius = 5 //
        issueBtn.layer.cornerRadius = 5 //
        userBtn.layer.cornerRadius = 5 //
        repoBtn.layer.cornerRadius = 5 //

        // Do any additional setup after loading the view, typically from a nib.
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func codeBtn(sender: UIButton) {
    }

    @IBAction func issueBtn(sender: UIButton) {
    }

    @IBAction func repoBtn(sender: UIButton) {
    }
    @IBAction func userBtn(sender: UIButton) {
    }
}

