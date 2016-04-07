//
//  KodListeleViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 17.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class KodListeleViewController: UIViewController,UITableViewDataSource , UITableViewDelegate{
    
    var waitingView  = WaitingView()

    var code_url_string = String()

    var dosya_adi = [String]() // isimleri çekeceğimiz array
    var dosya_urls = [String]() // repoları çekeceğimiz array

    var repo_update_date = [String]() // update'leri çekeceğimiz array
    
    
    @IBOutlet var codetableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // kod_bul()
        
        codesearch()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func kod_bul(){
        
        let repo_sahip = KeychainSwift.get("repo_sahip")
        print(repo_sahip)
        let repo_ad = KeychainSwift.get("repo_ad")
        print(repo_ad)
        let repo_dil = KeychainSwift.get("repo_dil")
        print(repo_dil)
        
      
        let search_replaced = repo_ad!.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        var url = String()
        url = "https://api.github.com/search/code?q=language:"+repo_dil!
        
        var url2 = String()
        url2 = "+repo:"+repo_sahip!
        
        var url3 = String()
        url3 = "/"+search_replaced
        
        
        code_url_string = url+url2+url3
        
        print(code_url_string)

       
        // bu metod ile veriyi çekecez
        
        let endpoint = NSURL(string: code_url_string) // veriyi çekeceğin url yi giriyorsun burası post olunca değişiyor
        let data = NSData(contentsOfURL: endpoint!) // isteği yaptıkran sonra gelen data
        
        do { //try-catch in swift hali
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            // datayı json olarak pars etti. bak json çıktının dışında süslü parantez olduğu için biz JSONObject olarak çektim
            
            if let items = json["items"] as? [[String: AnyObject]] {
                for item in items { // burası klasik foreach
                    if let name = item["name"] as? String {
                        dosya_adi.append(name)
                    }
                    if let dosya_url = item["html_url"] as? String {
                        dosya_urls.append(dosya_url)
                    }
                    
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
            
            SweetAlert().showAlert("Bilgi!", subTitle: "Arama Alanını Boş Bırakmayınız.", style: AlertStyle.Warning)
            
            
        }
        // burada konsola bastır
        print(dosya_adi)
        print(dosya_urls)
        
    }
    

    func codesearch(){
            
            waitingView  = WaitingView(frame : self.view.bounds)
            self.view.addSubview(waitingView) // bu kısmı ilgili ekrana init etmek için kullanıyoruz
        
        let repo_sahip = KeychainSwift.get("repo_sahip")
        print(repo_sahip)
        let repo_ad = KeychainSwift.get("repo_ad")
        print(repo_ad)
        let repo_dil = KeychainSwift.get("repo_dil")
        print(repo_dil)
            // bu metod ile veriyi çekecez
            
            
        let search_replaced = repo_ad!.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        var url = String()
        url = "https://api.github.com/search/code?q=language:"+repo_dil!
        
        var url2 = String()
        url2 = "+repo:"+repo_sahip!
        
        var url3 = String()
        url3 = "/"+search_replaced
        
        
        code_url_string = url+url2+url3
        
        print(code_url_string)

            
            let endpoint = NSURL(string: code_url_string) // veriyi çekeceğin url yi giriyorsun burası post olunca değişiyor
            
            let request = NSMutableURLRequest(URL:endpoint!);
            request.HTTPMethod = "GET";
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
                
                //status code u alıyoruz
                let httpResponse = response as! NSHTTPURLResponse
                let statuscode = httpResponse.statusCode
                print(statuscode)
                // Print out response body
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                
                if statuscode == 200 {
                    // Print out response body
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                    
                    let data = NSData(contentsOfURL: endpoint!) // isteği yaptıkran sonra gelen data
                    
                    do { //try-catch in swift hali
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        // datayı json olarak pars etti. bak json çıktının dışında süslü parantez olduğu için biz JSONObject olarak çektim
                        
                        
                        
                        if let items = json["items"] as? [[String: AnyObject]] {
                            for item in items { // burası klasik foreach
                                if let name = item["name"] as? String {
                                    self.dosya_adi.append(name)
                                }
                                if let dosya_url = item["html_url"] as? String {
                                    self.dosya_urls.append(dosya_url)
                                }
                                
                            }
                        }
                    } catch {
                        print("error serializing JSON: \(error)")
                        
                        SweetAlert().showAlert("Bilgi!", subTitle: "Arama Alanını Boş Bırakmayınız.", style: AlertStyle.Warning)
                        
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        if(self.dosya_adi.count == 0){
                            dispatch_async(dispatch_get_main_queue(),{
                                self.waitingView.removeFromSuperview()
                                SweetAlert().showAlert("Bilgi!", subTitle: "Aranılan kod bulunamadı", style: AlertStyle.Warning)
                            })
                        }else{
                            self.codetableview.reloadData()
                        }
                        self.waitingView.removeFromSuperview()
                    })
                }else{
                    dispatch_async(dispatch_get_main_queue(),{
                        self.waitingView.removeFromSuperview()
                        SweetAlert().showAlert("Hata", subTitle: "Arama alanını boş bırakmayınız!", style: AlertStyle.Warning, buttonTitle:"Tamam", buttonColor:UIColor.darkGrayColor()) { (isOtherButton) -> Void in
                            if isOtherButton == true {
                                // neden navigation controller kullandığımız sorusunun cevabı. Bize her controlleri yaparken navigation controller kullandığımızdan.
                                // pop view da tıpkı stacklarde olduğu gibi en üstteki controller ı "pop" ediyor...
                                self.navigationController?.popViewControllerAnimated(true)
                            }
                        }
                        //SweetAlert().showAlert("Bilgi!", subTitle: "Bir hata meydana geldi.", style: AlertStyle.Error)
                    })
                }
            }
            task.resume()
            
        }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dosya_adi.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell    =   tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
       var dosyaadiLabel =  UILabel()
        dosyaadiLabel = cell.viewWithTag(1) as! UILabel
        dosyaadiLabel.text = dosya_adi[indexPath.row]
        
        
    
        cell.backgroundColor            =   UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("kisa tıklandi")
        
        KeychainSwift.set(self.dosya_urls[indexPath.row], forKey: "dosya_urls")
    }

    
}