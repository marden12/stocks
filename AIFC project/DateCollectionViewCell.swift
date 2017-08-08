//
//  DateCollectionViewCell.swift
//  AIFC project
//
//  Created by Dayana Marden on 11.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class DateCollectionViewCell: UICollectionViewCell {
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Standart.font.rawValue, size: 18)
        label.isUserInteractionEnabled = true
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(dateLabel)
        setupConstraints()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints(){
        constrain(self,dateLabel){ s,sL in
            sL.center == s.center
        }
    }

}
