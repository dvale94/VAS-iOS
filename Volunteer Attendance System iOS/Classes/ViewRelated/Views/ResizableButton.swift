//
//  ResizableButton.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/8/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class ResizableButton: UIButton {
    
    override var titleEdgeInsets: UIEdgeInsets {
        set {}
        get {
            return UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        }
    }

    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)

        return desiredButtonSize
    }
    
    override func layoutSubviews() {
        titleLabel?.preferredMaxLayoutWidth = frame.size.width
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.size.height / 2
    }

}
