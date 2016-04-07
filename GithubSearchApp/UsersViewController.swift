//
//  UsersViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 18.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    @IBOutlet weak var useraraBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        useraraBtn.layer.cornerRadius = 5 //

                // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useraraBtn(sender: UIButton) {
     /*  if ((username.text?.isEmpty) != nil){
            let optionMenu = UIAlertController(title: nil, message: "Arama Alanını Boş Bırakmayın!", preferredStyle: .Alert)
            
            
            let cancelAction = UIAlertAction(title: "Tamam", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                
            })
            optionMenu.addAction(cancelAction)
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
            
            
        }
            */
            
        //else{
            
            let kullaniciadi = username.text!
            KeychainSwift.set(kullaniciadi, forKey: "kullanici_adi")
            print(kullaniciadi)
            
      //  }
        
        
        
       
        
    }

    
    
}