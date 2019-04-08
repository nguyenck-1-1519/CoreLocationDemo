//
//  CustomInfoWindow.swift
//  CoreLocationDemo
//
//  Created by can.khac.nguyen on 4/8/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView {
    
    @IBOutlet var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
    }
}
