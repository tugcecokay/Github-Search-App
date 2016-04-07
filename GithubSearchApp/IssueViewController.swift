//
//  IssueViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 28.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class IssueViewController: UIViewController {
    
    @IBOutlet weak var issue_adi: UITextField!
    
    @IBOutlet weak var sira_detay: UIButton!
    @IBOutlet weak var arama_detay: UIButton!
    @IBOutlet weak var ara_btn: UIButton!
    
    
    var spinner_value: [String] = ["Comments", "Created", "Updated"]
    
    var spinner_value2: [String] = ["Azalan", "Artan"]
    override func viewDidLoad() {
        super.viewDidLoad()
        sira_detay.layer.cornerRadius = 5 //
        arama_detay.layer.cornerRadius = 5
        ara_btn.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sira_detayAction(sender: UIButton) {
        
        let optionMenu = UIAlertController(title: nil, message: "Sıralama Seçiniz", preferredStyle: .Alert)
        for (index, value) in self.spinner_value2.enumerate() {
            optionMenu.addAction(UIAlertAction(title: value, style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                self.sira_detay.titleLabel!.text = self.spinner_value2[index]
                
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
    @IBAction func arama_detayAction(sender: UIButton) { //Aramanın tipinin seçilmesini sağlayan buton fonksiyonu
        
        let optionMenu = UIAlertController(title: nil, message: "Tip Seçiniz", preferredStyle: .Alert)
        for (index, value) in self.spinner_value.enumerate() {
            optionMenu.addAction(UIAlertAction(title: value, style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                self.arama_detay.titleLabel!.text = self.spinner_value[index]
                
                if self.spinner_value[index] == "Comments"{
                    KeychainSwift.set("comments", forKey: "tip")
                }else if self.spinner_value[index] == "Created"{
                    KeychainSwift.set("created", forKey: "tip")
                }else {
                    KeychainSwift.set("updated", forKey: "tip")
                }
            }))
            
        }
        
        let cancelAction = UIAlertAction(title: "Çıkış", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        
    }

    
      @IBAction func ara_btn(sender: UIButton) {
        let issueanahtar = issue_adi.text!
        KeychainSwift.set(issueanahtar, forKey: "issueanahtar")
        
        
    }
    
}