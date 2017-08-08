//
//  MenuTableViewCell.swift
//  AIFC project
//
//  Created by Dayana Marden on 02.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class MenuTableViewCell: UITableViewCell {
    fileprivate lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Settings"
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
        self.addSubview(title)
    }
    func setupConstraints(){
        constrain(self,title){ s,title in
            title.left == s.left + 16
            title.top == s.top + 16
        }
    }



}
