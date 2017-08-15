//
//  LoginViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 19.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import FirebaseAuth
import SkyFloatingLabelTextField
import GSMessages

class LoginViewController: UIViewController {
    let authService = AuthenticationService()
    fileprivate lazy var logoTite: UILabel = {
        let label = UILabel()
        label.text = "AIFC"
        label.font = UIFont(name: "OpenSans-Light", size: 64)
        
        label.textColor = .white
        return label
    }()
    fileprivate lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Email"
        textField.placeholderColor = .white
        textField.title = "Write yout email"
        textField.titleColor = .white
        return textField
        
    }()
    fileprivate lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Password"
        textField.placeholderColor = .white
        textField.title = "Write yout password"
        textField.titleColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    fileprivate lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(.backgroundColor, for: .normal)
        button.addTarget(self, action: #selector(submitAction(_:)), for: .touchUpInside)
        return button
    }()
    fileprivate lazy var regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have account?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(goToRegistrationViewController(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        setupViews()
        setupConstraints()

    }
        func submitAction(_:UIButton){
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        let password = passwordTextField.text!
            authService.signIn(finalEmail, password: password, vs: self)
        
    }
    
    func setupViews(){
        view.addSubview(logoTite)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)
        view.addSubview(regButton)
        

    }
    func goToRegistrationViewController(_:UIButton){
        let nextVC = RegistrationViewController()
        navigationController?.present(nextVC, animated: true, completion: nil)
    }
    
    func setupConstraints(){

        constrain(logoTite,view,emailTextField,passwordTextField,submitButton){ logo,v,eTF,pTF,button in
            logo.centerX == v.centerX
            logo.top == v.top + 50
            
            eTF.top == logo.bottom + 16
            eTF.centerX == v.centerX
            eTF.width == v.width - 32

            eTF.height == 45
            
            pTF.top == eTF.bottom
            pTF.centerX == v.centerX
            pTF.width == v.width - 32
            pTF.height == 45
            
            button.width == v.width - 32
            button.height == 45
            button.top == pTF.bottom + 16
            button.centerX == v.centerX
        }
        
        constrain(regButton,submitButton,view){ reg,button,v in
            reg.width == v.width/2
            reg.height == 45
            reg.top == button.bottom + 10
            reg.centerX == button.centerX
        }
    }
}
    

