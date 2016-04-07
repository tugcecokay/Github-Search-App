//
//  UsersListViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 18.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController,UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var tableview: UITableView!
    
    var waitingView  = WaitingView() //waitingview classını controllerda kullanmak için çağırdık

    var users_url_string = String()
    
    var k_adi = [String]() // isimleri çekeceğimiz array
    var k_urls = [String]() // url çekeceğimiz array
    var k_avatar_url = [String]() // avatar url çekeceğimiz array

    
    
    var repo_update_date = [String]() // update'leri çekeceğimiz array
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //users_bul()
        search_users()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func users_bul(){
        
        let kullanici_adi = KeychainSwift.get("kullanici_adi")
        print(kullanici_adi)
        
       
        // bu metod ile veriyi çekecez
        
        users_url_string = "https://api.github.com/search/users?q="+kullanici_adi!
        
        print(users_url_string)
        
        let endpoint = NSURL(string: users_url_string) // veriyi çekeceğin url yi giriyorsun burası post olunca değişiyor

        
        let data = NSData(contentsOfURL: endpoint!) // isteği yaptıkran sonra gelen data
        
        do { //try-catch in swift hali
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            // datayı json olarak pars etti. bak json çıktının dışında süslü parantez olduğu için biz JSONObject olarak çektim
            
            
            if let items = json["items"] as? [[String: AnyObject]] {
                for item in items { // burası klasik foreach
                    if let name = item["login"] as? String {
                        k_adi.append(name)
                    }
                    if let kull_url = item["html_url"] as? String {
                        k_urls.append(kull_url)
                    }
                    if let kullav_url = item["avatar_url"] as? String {
                        k_avatar_url.append(kullav_url)
                    }
                    
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
            
            SweetAlert().showAlert("Bilgi!", subTitle: "Arama Alanını Boş Bırakmayınız.", style: AlertStyle.Warning)
            
            
        }
        // burada konsola bastır
        print(k_adi)
        print(k_urls)
        print(k_avatar_url)

    }
    
    func search_users(){
        
        waitingView  = WaitingView(frame : self.view.bounds)
        self.view.addSubview(waitingView) // bu kısmı ilgili ekrana init etmek için kullanıyoruz
        
        let kullanici_adi = KeychainSwift.get("kullanici_adi")
        print(kullanici_adi)
        
        // bu metod ile veriyi çekecez
        
        
        
        
        users_url_string = "https://api.github.com/search/users?q="+kullanici_adi!
        
        print(users_url_string)
        
        let endpoint = NSURL(string: users_url_string) // veriyi çekeceğin url yi giriyorsun burası post olunca değişiyor
        
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
                            if let name = item["login"] as? String {
                                self.k_adi.append(name)
                            }
                            if let kull_url = item["html_url"] as? String {
                                self.k_urls.append(kull_url)
                            }
                            if let kullav_url = item["avatar_url"] as? String {
                                self.k_avatar_url.append(kullav_url)
                            }
                            
                        }
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                    
                    SweetAlert().showAlert("Bilgi!", subTitle: "Boş kullanıcı adi girdiniz", style: AlertStyle.Error)
                    
                    
                }
                
                dispatch_async(dispatch_get_main_queue(),{
                    if(self.k_adi.count == 0){
                        dispatch_async(dispatch_get_main_queue(),{
                            self.waitingView.removeFromSuperview()
                            SweetAlert().showAlert("Bilgi!", subTitle: "Aranılan kullanıcı bulunamadı", style: AlertStyle.Warning)
                            /*let optionMenu = UIAlertController(title: nil, message: "Arama Alanını Boş Bırakmayın!", preferredStyle: .Alert)
                            
                            
                            let cancelAction = UIAlertAction(title: "Tamam", style: .Cancel, handler: {
                                (alert: UIAlertAction!) -> Void in
                                
                            })
                            optionMenu.addAction(cancelAction)
                            self.presentViewController(optionMenu, animated: true, completion: nil)
                            */
                            

                        })
                    }else{
                        self.tableview.reloadData()
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
        return k_adi.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell    =   tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        var dosyaadiLabel =  UILabel()
        dosyaadiLabel = cell.viewWithTag(2) as! UILabel
        dosyaadiLabel.text = k_adi[indexPath.row]
        
        
        var image = UIImageView()
        image = cell.viewWithTag(1) as! UIImageView
        let url = NSURL(string: k_avatar_url[indexPath.row])
        let data = NSData(contentsOfURL: url!)
        image.image = UIImage(data: data!)
        
        
        cell.backgroundColor            =   UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("kisa tıklandi")
        
        KeychainSwift.set(self.k_urls[indexPath.row], forKey: "kullanici_urls")
    }
    



}