//
//  VisitorController.swift
//  GlacierScenics
//
//  Created by ant.man on 2016. 12. 26..
//  Copyright © 2016년 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import AlamofireObjectMapper

class VisitorController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var visitors : [Visitor] = []
    var pageNo : Int = 0
    
    @IBOutlet weak var tableview: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadTag()
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadTag() {
        
        let url = "https://test.owltree.us/users/U15858C3C6CBAP6D0F61CA/visitors/0"
        
        let parameters: Parameters = [
            "access_token": "9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseArray { (response: DataResponse<[Visitor]>) in
            
            guard response.result.isSuccess else {
                print("Error while request : \(response.result.error)")
                return
            }
            
            let visitorArray = response.result.value
            if let visitorArray = visitorArray {
                for visitor in visitorArray {
                    print("visitor name: " + (visitor.user?.name!)!)
                    self.visitors.append(visitor)
                }
            }
            self.tableview.reloadData()
        }
        self.pageNo += 1 // 다음 호출 시 다음 페이지 호출 할 준비
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitors.count
    }
    
    func dayStringFromTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy. MM. dd a hh:mm"
        //dateFormatter.timeZone = NSTimeZone() as TimeZone!
        return dateFormatter.string(from: date as Date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitorCell", for: indexPath) as! VisitorCell
        cell.VisitorLable.text = visitors[indexPath.row].user?.name;
        cell.VisitDateLabel.text = dayStringFromTime(unixTime: Double(visitors[indexPath.row].regDt!/1000));
        
        let url = URL(string: (visitors[indexPath.row].user?.picture) ?? "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png")
        cell.imageView?.af_setImage(withURL: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row is " , indexPath.row)
    }

    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
