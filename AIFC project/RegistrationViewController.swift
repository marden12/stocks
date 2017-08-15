//
//  RegistrationViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 18.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import SkyFloatingLabelTextField

class RegistrationViewController: UIViewController {
    
    let authService = AuthenticationService()
    fileprivate lazy var logoTite: UILabel = {
        let label = UILabel()
        label.text = "AIFC"
        label.font = UIFont(name: "OpenSans-Light", size: 64)
        label.textColor = .white
        return label
    }()
    fileprivate lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Nickname"
        textField.placeholderColor = .white
        textField.title = "Write yout nickname"
        textField.titleColor = .white
        return textField
    }()
    fileprivate lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Email"
        textField.placeholderColor = .white
        textField.title = "Write your email"
        textField.titleColor = .white
        return textField
        
    }()
    fileprivate lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Password"
        textField.placeholderColor = .white
        textField.title = "Write your password"

        textField.isSecureTextEntry = true
        return textField
    }()
    fileprivate lazy var loginBitton: UIButton = {
        let button = UIButton()
        button.setTitle("Have an account?", for: .normal)
        button.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    fileprivate lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(.backgroundColor, for: .normal)
        button.addTarget(self, action: #selector(submitAction(_:)), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupViews()
        setupConstraints()
    }
    func submitAction (_:UIButton){
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        let password = passwordTextField.text!
        let username = nameTextField.text!
        
        if  password.isEmpty {
            self.view.endEditing(true)
            print("error")
        } else {
            self.view.endEditing(true)
            authService.signUp(finalEmail,password: password, username: username,vc: self)
        }

    }
    func gotoLogin(){
        self.dismiss(animated: true, completion: nil)
    }
    func setupViews(){
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)
        view.addSubview(loginBitton)
        view.addSubview(logoTite)
    }

    
    func setupConstraints(){
        
        constrain(logoTite,view,nameTextField,emailTextField){logo,v,name,eTF in
            logo.centerX == v.centerX
            logo.top == v.top + 100
            
            name.top == logo.bottom + 16
            name.centerX == v.centerX
            name.width == v.width - 32
            name.height == 45

            eTF.top == name.bottom
            eTF.centerX == v.centerX
            eTF.width == v.width - 32
            eTF.height == 45
            
        }
        constrain(view,emailTextField,passwordTextField,submitButton,loginBitton) { v,eTF,pTF,button,login in
            pTF.top == eTF.bottom
            pTF.centerX == v.centerX
            pTF.width == v.width - 32
            pTF.height == 45
            
            button.width == v.width - 32
            button.height == 45
            button.top == pTF.bottom + 16
            button.centerX == v.centerX
            
            login.width == v.width/2
            login.height == 45
            login.top == button.bottom + 10
            login.centerX == button.centerX
        }
    }
}
