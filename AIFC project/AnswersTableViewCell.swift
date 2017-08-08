//
//  AnswersCollectionViewCell.swift
//  AIFC project
//
//  Created by Dayana Marden on 26.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class AnswersTableViewCell: UITableViewCell {
    
    public lazy var answerLAbel: UILabel = {
        let label = UILabel()
        label.text = "Answer1"
        label.font = UIFont(name: Standart.font.rawValue, size: 16)
        return label
    }()
    public lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 5
        return view
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
        self.addSubview(backView)
        backView.addSubview(answerLAbel)
    }
    func setupConstraints(){
        constrain(self,answerLAbel,backView){s,label,bv in
            label.center == s.center
            bv.center == s.center
            bv.width == s.width - 32
            bv.height == s.height - 32
        }
    }

}
