//
//  QuizViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 25.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

struct Questions {
    var id: Int64
    var quest = ""
    var ans: [String]
    var sequenceOfNumbers: [Int]
    var choosenAnswer =  -1
}

class QuizViewController: UIViewController {
    
    let questions = ["How r u","What is your name","How old r u"]
    let answers = [["good","fine","well","bad"],["D","T","B","C"],["21","24","34","56"]]
    
    var currentQuestions = 0
    var rightAnswerPlacement: UInt32 = 0

    let navBar = UINavigationBar()
    
    fileprivate lazy var viewForQuestion: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    fileprivate lazy var previousQuestion: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "left"), for: .normal)
        return button
    }()
    fileprivate lazy var nextQuestion: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right"), for: .normal)
        return button
    }()
    fileprivate lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question"
        label.font = UIFont(name: Standart.font.rawValue, size: 28)
        return label
    }()
    fileprivate lazy var aVariant: CustomAnswerButton = {
        let button = CustomAnswerButton()
        button.addTarget(self, action: #selector(chooseAnswerAction(sender:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    fileprivate lazy var bVariant: CustomAnswerButton = {
        let button = CustomAnswerButton()
        button.addTarget(self, action: #selector(chooseAnswerAction(sender:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    fileprivate lazy var cVariant: CustomAnswerButton = {
        let button = CustomAnswerButton()
        button.addTarget(self, action: #selector(chooseAnswerAction(sender:)), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    fileprivate lazy var dVariant: CustomAnswerButton = {
        let button = CustomAnswerButton()
        button.addTarget(self, action: #selector(chooseAnswerAction(sender:)), for: .touchUpInside)
        button.tag = 4
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        displayNewQuestion()
    }
    func chooseAnswerAction(sender:UIButton){
        if sender.tag == Int(rightAnswerPlacement){
            print("right")
        }else{
            print("false")
        }
        
        if currentQuestions != questions.count{
            displayNewQuestion()
        }
    }
    func setupViews(){
        viewForQuestion.addSubview(questionLabel)
        view.addSubview(viewForQuestion)
        view.addSubview(previousQuestion)
        view.addSubview(nextQuestion)
        view.addSubview(aVariant)
        view.addSubview(bVariant)
        view.addSubview(cVariant)
        view.addSubview(dVariant)
    }
    
    func setupConstraints(){
        constrain(view,viewForQuestion,questionLabel){ v, qv,ql in
            ql.center == qv.center
            qv.width == v.width - 64
            qv.height == v.height/3
            qv.centerX == v.centerX
            qv.top == v.top + 10
            
        }
        constrain(viewForQuestion,previousQuestion,view,nextQuestion,aVariant){qv,leftButoon,v,rightButton,a in
            leftButoon.left == v.left + 5
            leftButoon.right == qv.left - 5
            leftButoon.centerY == qv.centerY
            
            rightButton.right == v.right + 5
            rightButton.left == qv.right - 5
            rightButton.centerY == qv.centerY
            
            a.width == v.width - 40
            a.height == 64
            a.top == qv.bottom + 16
            a.centerX == qv.centerX
            
        }
        constrain(aVariant,bVariant,cVariant,dVariant,view){a,b,c,d,v in
            b.top == a.bottom + 24
            c.top == b.bottom + 24
            d.top == c.bottom + 24
            
            b.width == v.width - 32
            b.height == 64
            b.centerX == v.centerX
            
            c.width == v.width - 32
            c.height == 64
            c.centerX == v.centerX
            
            d.width == v.width - 32
            d.height == 64
            d.centerX == v.centerX


    
            
            
        }
    }
    func displayNewQuestion(){
        questionLabel.text = questions[currentQuestions]
        rightAnswerPlacement = arc4random_uniform(4)+1
        
        var button: UIButton = UIButton()
        var x = 1
        for i in 1...4{

            button = view.viewWithTag(i) as! UIButton
            if i == Int(rightAnswerPlacement){
                button.setTitle(answers[currentQuestions][0], for: .normal)
                
            }else{
                button.setTitle(answers[currentQuestions][x], for: .normal)
                x = 2
            }
           
        }
        currentQuestions += 1

        
        
    }
}
