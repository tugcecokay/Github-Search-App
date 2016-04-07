//
//  AramaIslemViewController.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 11.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class RepoIslemViewController: UIViewController,UITableViewDataSource , UITableViewDelegate  {
   
    var waitingView  = WaitingView()

    var repo_adi = [String]() // isimleri çekeceğimiz array
    var repo_urls = [String]() // repoları çekeceğimiz array
    var repo_stars = [Int]() // stars sayısını çekeceğimiz array
    var repo_forks = [Int]() // forks sayısını çekeceğimiz array
    var repo_update_date = [String]() // update'leri çekeceğimiz array
    var repo_url_string = String()
    
   // var _data_repo: [AnyObject] = [AnyObject]()

    @IBOutlet var repotableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //repo_bul()
        reposearch()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    func reposearch(){
        
    waitingView  = WaitingView(frame : self.view.bounds)//bekleyiniz uyarısı için gerekli
    
    self.view.addSubview(waitingView) // bu kısmı ilgili ekrana init etmek için kullanıyoruz
    
    let tips = KeychainSwift.get("tip")//Aramavievcontroller dan arama tipinin değişkene atanması
    print(tips)
    let sira = KeychainSwift.get("sira")
    print(sira)
    let search = KeychainSwift.get("repo_anahtar")
    print(search)
    
    let search_replaced = search!.stringByReplacingOccurrencesOfString(" ", withString: "-")//textfiel dan gelen string in boşluklarını - işareti ile değiştirir.
        
        if tips == "stars" && sira == "azalan"{
            repo_url_string = "https://api.github.com/search/repositories?q="+search_replaced+"&sort=stars&order=desc"
            
        }
        else if tips == "stars" && sira == "artan"{
            repo_url_string = "https://api.github.com/search/repositories?q="+search_replaced+"&sort=stars&order=asc"
        }
        else if tips == "forks" && sira == "azalan" {
            
            repo_url_string = "https://api.github.com/search/repositories?q="+search_replaced+"&sort=forks&order=desc"
            
        }
        else if tips == "forks" && sira == "artan" {
            
            repo_url_string = "https://api.github.com/search/repositories?q="+search_replaced+"&sort=forks&order=asc"
            
        }
        else{
            repo_url_string = "https://api.github.com/search/repositories?q="+search_replaced
            
        }
        print(repo_url_string)
        
    let endpoint = NSURL(string: repo_url_string) // verinin çekieleceği url. Burası post olunca değişiyor
    
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
                // datayı json olarak pars etti. Json çıktının dışında süslü parantez olduğu için biz JSONObject olarak çektim
                
                if let items = json["items"] as? [[String: AnyObject]] {
                    for item in items { // burası klasik foreach
                        if let name = item["name"] as? String {
                            self.repo_adi.append(name)
                        }
                        if let repo_url = item["html_url"] as? String {
                            self.repo_urls.append(repo_url)
                        }
                        if let star = item["stargazers_count"] as? Int {
                            self.repo_stars.append(star)                     }
                        if let fork = item["forks"] as? Int {
                            self.repo_forks.append(fork)
                        }
                        if let update = item["updated_at"] as? String {
                            self.repo_update_date.append(update)
                        }
                        
                    }
                }
            } catch {
                print("error serializing JSON: \(error)")
                
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                if(self.repo_adi.count == 0){
                    dispatch_async(dispatch_get_main_queue(),{
                        self.waitingView.removeFromSuperview()
                        SweetAlert().showAlert("Bilgi!", subTitle: "Aranılan kod bulunamadı", style: AlertStyle.Warning)
                    })
                }
                else{
                    self.repotableview.reloadData()
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
        return repo_adi.count
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell    =   tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        var repoadiLabel =  UILabel()
        repoadiLabel = cell.viewWithTag(2) as! UILabel
        repoadiLabel.text = repo_adi[indexPath.row]
        
        
        var starsLabel =  UILabel()
        starsLabel = cell.viewWithTag(3) as! UILabel
        starsLabel.text = String(repo_stars[indexPath.row])
        
        var forksLabel =  UILabel()
        forksLabel = cell.viewWithTag(4) as! UILabel
        forksLabel.text = String(repo_forks[indexPath.row])
        
        
        var imagestars = UIImageView()
        imagestars = cell.viewWithTag(5) as! UIImageView
        imagestars.image = UIImage(named: "gtihubstar")
        
        var imageforks = UIImageView()
        imageforks = cell.viewWithTag(6) as! UIImageView
        imageforks.image = UIImage(named: "Code Fork-48")

        
        cell.backgroundColor            =   UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("kisa tıklandi")
        
        KeychainSwift.set(self.repo_urls[indexPath.row], forKey: "repo_urls")
    }


    
}