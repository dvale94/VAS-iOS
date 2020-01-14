//
//  BaseCollectionViewCell.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/12/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import TinyConstraints

class BaseCollectionViewCell: UICollectionViewCell {
    
    var type: HomeCollectionViewCellType!
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("No existing NIB found")
    }
    
    private func commonInit() {
        setupView()
    }
    
}

extension BaseCollectionViewCell {
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.masksToBounds = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        self.width(screenWidth - 50)
    }
}
