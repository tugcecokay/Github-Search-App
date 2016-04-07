//
//  KodAraViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 17.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class KodAraViewController: UIViewController {


    @IBOutlet var kullaniciAdi: UITextField!

    @IBOutlet var reposAdi: UITextField!
    @IBOutlet var dil: UITextField!
    
    @IBOutlet weak var kodaraBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        kodaraBtn.layer.cornerRadius = 5 //

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func kodaraBtn(sender: UIButton) {
        
        /*if reposahipadi.isEmpty{
        
        //print("leleleboş")
          //  SweetAlert().showAlert("Bilgi!", subTitle: "Arama Alanını Boş Bırakmayınız.", style: AlertStyle.Warning)
        
        }  if ((kullaniciAdi.text?.isEmpty) != nil){
            let optionMenu = UIAlertController(title: nil, message: "Arama Alanını Boş Bırakmayın!", preferredStyle: .Alert)
            
            
            let cancelAction = UIAlertAction(title: "Tamam", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                
            })
            optionMenu.addAction(cancelAction)
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
        }
        else{*/
            let reposahipadi = kullaniciAdi.text!
            KeychainSwift.set(reposahipadi, forKey: "repo_sahip")
            print(reposahipadi)
            let repoAdi = reposAdi.text!
            KeychainSwift.set(repoAdi, forKey: "repo_ad")
            print(repoAdi)
            
            let repodil = dil.text!
            KeychainSwift.set(repodil, forKey: "repo_dil")
            print(repodil)        }
        
        
    //}

}