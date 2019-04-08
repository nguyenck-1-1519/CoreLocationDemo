//
//  CustomMarkerView.swift
//  CoreLocationDemo
//
//  Created by can.khac.nguyen on 4/5/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import MapKit

class CustomMarkerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("CustomMarkerView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
    }
}
