//
//  IssueList.swift
//  GithubSearchApp
//
//  Created by Tuğçe ÇOKAY on 28.03.2016.
//  Copyright © 2016 Tuğçe ÇOKAY. All rights reserved.
//

import UIKit

class IssueListViewController: UIViewController,UITableViewDataSource , UITableViewDelegate {
    
    var waitingView  = WaitingView()
    var issue_adi = [String]() // isimleri çekeceğimiz array
    var issue_urls = [String]() // repoları çekeceğimiz array
    
    var issue_url_string = String()
    
    @IBOutlet weak var issuetableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       issuesearch()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func issuesearch() {
        
        waitingView  = WaitingView(frame : self.view.bounds)
        
        self.view.addSubview(waitingView) // bu kısmı ilgili ekrana init etmek için kullanıyoruz
        
        let tips = KeychainSwift.get("tip")
        print(tips)
        let sira = KeychainSwift.get("sira")
        print(sira)
        let search_replaced = KeychainSwift.get("issueanahtar")
        print(search_replaced)
        
        //let search_replaced = search!.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        if tips == "comments" && sira == "azalan"{
            issue_url_string = "https://api.github.com/search/issues?q="+search_replaced!+"+sort=comments&order=desc"
            
        }
        else if tips == "comments" && sira == "artan"{
            issue_url_string = "https://api.github.com/search/issues?q="+search_replaced!+"+sort=comments&order=asc"
        }
        else if tips == "created" && sira == "azalan" {
            
            issue_url_string = "https://api.github.com/search/issues?q="+search_replaced!+"+sort=created&order=desc"

            
        }
        else if tips == "created" && sira == "artan" {
            
            issue_url_string = "https://api.github.com/search/issues?q="+search_replaced!+"+sort=created&order=asc"
            
        }
        else{
            issue_url_string = "https://api.github.com/search/issues?q="+search_replaced!
            
        }
        print(issue_url_string)
        
        let endpoint = NSURL(string: issue_url_string) // veriyi çekeceğin url yi giriyorsun burası post olunca değişiyor
        
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
                            if let name = item["title"] as? String {
                                self.issue_adi.append(name)
                            }
                            if let issue_url = item["html_url"] as? String {
                                self.issue_urls.append(issue_url)
                            }
                        }
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                    
                }
                
                dispatch_async(dispatch_get_main_queue(),{
                    if(self.issue_adi.count == 0){
                        dispatch_async(dispatch_get_main_queue(),{
                            self.waitingView.removeFromSuperview()
                           
                             SweetAlert().showAlert("Bilgi!", subTitle: "Aranılan kod bulunamadı", style: AlertStyle.Warning)
                        })
                    }
                    else{
                        self.issuetableview.reloadData()
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
                   // SweetAlert().showAlert("Bilgi!", subTitle: "Bir hata meydana geldi.", style: AlertStyle.Error)
                })
            }
        }
        task.resume()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issue_adi.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell    =   tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        var issueadiLabel =  UILabel()
        issueadiLabel = cell.viewWithTag(1) as! UILabel
        issueadiLabel.text = issue_adi[indexPath.row]
        
        cell.backgroundColor            =   UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("kisa tıklandi")
        
        KeychainSwift.set(self.issue_urls[indexPath.row], forKey: "issue_urls")
    }

    
    
    }
    
    
