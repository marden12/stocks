//
//  SearchTableViewCell.swift
//  AIFC project
//
//  Created by Dayana Marden on 20.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class SearchTableViewCell: UITableViewCell {
    public lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "GOOG"
        label.font = UIFont(name: Standart.font.rawValue, size: 24)
        return label
    }()
    public lazy var postDate: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "27.06.2015"
        label.font = UIFont(name: Standart.font.rawValue, size: 16)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented coder")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupViews(){
        self.addSubview(postDate)
        self.addSubview(newsTitle)
    }
    func setupConstraints(){
        constrain(self,postDate,newsTitle){ s,p,n in
            n.left == s.left + 10
            n.centerY == s.centerY
            p.top == n.bottom
            p.left == s.left + 10
            
        }
    }

}
