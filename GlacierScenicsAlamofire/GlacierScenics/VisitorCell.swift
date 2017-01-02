//
//  ViewTableCellTableViewCell.swift
//  GlacierScenics
//
//  Created by ant.man on 2016. 12. 27..
//  Copyright © 2016년 Todd Kramer. All rights reserved.
//

import UIKit

class VisitorCell: UITableViewCell {

    @IBOutlet weak var VisitorImage: UIImageView!
    
    @IBOutlet weak var VisitorLable: UILabel!
//    @IBOutlet weak var VisitorButton: UIButton!
    @IBOutlet weak var VisitDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
