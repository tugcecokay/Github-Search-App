//
//  AramaViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 10.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    @IBOutlet weak var repoadi: UITextField!
    @IBOutlet weak var detaybtn: UIButton!
    @IBOutlet weak var siraBtn: UIButton!
    @IBOutlet weak var araBtn: UIButton!
    
    var spinner_value: [String] = ["Stars", "Forks", "Update"]//detaybtn için gerekli array
    
    var spinner_value2: [String] = ["Azalan", "Artan"]//sirabtn için gerekli array

    override func viewDidLoad() {
        super.viewDidLoad()
        detaybtn.layer.cornerRadius = 5 //butonların köşelerinin yuvarlatılmasını sağlar
        siraBtn.layer.cornerRadius = 5 //
        araBtn.layer.cornerRadius = 5 //

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func detaybtnAction(sender: UIButton) { //Arama tipinin seçilmesini sağlayan buton fonksiyonu
    
        let optionMenu = UIAlertController(title: nil, message: "Tip Seçiniz", preferredStyle: .Alert)
        for (index, value) in self.spinner_value.enumerate() {
            optionMenu.addAction(UIAlertAction(title: value, style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                self.detaybtn.titleLabel!.text = self.spinner_value[index]
                
                if self.spinner_value[index] == "Stars"{
                    KeychainSwift.set("stars", forKey: "tip")
                }else if self.spinner_value[index] == "Forks"{
                    KeychainSwift.set("forks", forKey: "tip")
                }else {
                    KeychainSwift.set("update", forKey: "tip")
                }
            }))
            
        }
        
        let cancelAction = UIAlertAction(title: "Çıkış", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    
    
}
    
    @IBAction func siraBtnAction(sender: UIButton) {//Arama sıralama tipinin seçilmesini sağlayan buton fonksiyonu
        
        let optionMenu = UIAlertController(title: nil, message: "Sıralama Seçiniz", preferredStyle: .Alert)
        for (index, value) in self.spinner_value2.enumerate() {
            optionMenu.addAction(UIAlertAction(title: value, style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                self.siraBtn.titleLabel!.text = self.spinner_value2[index]
                
                if self.spinner_value2[index] == "Artan"{
                    KeychainSwift.set("artan", forKey: "sira")
                }else {
                    KeychainSwift.set("azalan", forKey: "sira")
                }
            }))
            
        }
        
        let cancelAction = UIAlertAction(title: "Çıkış", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        
    }
    @IBAction func araBtn(sender: UIButton) {
      /*  if ((repoadi.text?.isEmpty) != nil){
       let optionMenu = UIAlertController(title: nil, message: "Arama Alanını Boş Bırakmayın!", preferredStyle: .Alert)
    
            
            let cancelAction = UIAlertAction(title: "Tamam", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                
            })
            optionMenu.addAction(cancelAction)
            self.presentViewController(optionMenu, animated: true, completion: nil)

      
      
    }
            
        
        else{*/
            let repoanahtar = repoadi.text!
            KeychainSwift.set(repoanahtar, forKey: "repo_anahtar")
        //}
        
    
    
    
}




}