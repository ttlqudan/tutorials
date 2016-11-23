//
//  AKMediaFocusBasicToolbarController.swift
//  AKMediaViewer
//
//  Created by Diogo Autilio on 3/23/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import Foundation
import UIKit

public class AKMediaFocusBasicToolbarController : UIViewController {
    
    @IBOutlet var doneButton: UIButton!
    
    
    public override func viewDidLoad() {
        
        doneButton.setTitle(NSLocalizedString("Done", comment: "Done"), for: UIControlState())
        doneButton.setTitleColor(UIColor.white, for: UIControlState())
        doneButton.backgroundColor =  UIColor.init(white: 0, alpha: 0.5)
        doneButton.sizeToFit()
        
        doneButton.frame = self.doneButton.frame.insetBy(dx: -20, dy: -4)
        doneButton.layer.borderWidth = 2
        doneButton.layer.cornerRadius = 4
        doneButton.layer.borderColor = UIColor.white.cgColor
    }
}
