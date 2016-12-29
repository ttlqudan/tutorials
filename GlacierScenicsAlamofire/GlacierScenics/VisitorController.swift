//
//  VisitorController.swift
//  GlacierScenics
//
//  Created by ant.man on 2016. 12. 26..
//  Copyright © 2016년 Todd Kramer. All rights reserved.
//

import UIKit

class VisitorController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var Titles = ["One", "Two", "Three", "Four", "Five"]
    
    @IBOutlet weak var tableview: UITableView!
 
    // label에 들어갈 string과 assets에 저장된 이미지 이름 배열
//    let menus = ["swift","tableview","example"]
//    let images = ["dog1","dog2","dog3"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitorCell", for: indexPath) as! VisitorCell
        cell.VisitorLable.text = Titles[indexPath.row]
        cell.VisitorImage.image =  UIImage(named: Titles[indexPath.row])
//        cell.imageView?.image = UIImage(named: Titles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row is " , indexPath.row)
    }

    
}


/*
// tableview의 datasource와 delegate 등록
extension VisitorController: UITableViewDataSource{
    

    
    // table row 갯수 (menu 배열의 갯수만큼)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    // 각 row 마다 데이터 세팅.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableview.dequeueReusableCellWithIdentifier("VisitorCell", forIndexPath: indexPath) as! VisitorCell
        
        // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.
        cell.tvLabel.text = menus[indexPath.row]
        cell.tvImageView.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
}

extension VisitorController: UITableViewDelegate{
    
}*/
