//
//  LoginView.swift
//  Seasonality
//
//  Created by Jack Wong on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit


class LoginView:UIView {
    
    
    public lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "Email"
        
        return textfield
    }()
    
    public lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        return tf
    }()
    
    public lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    public lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.textAlignment = .center
        
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var stackView: UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, errorLabel])
        
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 20
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpEverything()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpEverything()
    }
    
    private func setUpEverything() {
        backgroundColor = .white
        
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(errorLabel)
        addSubview(stackView)
        //
        setUpEmailTextFieldConstraints()
        setUpPasswordTextFieldConstraints()
        setUpLoginButtonConstraints()
        setUpErrorLabelContraints()
        setUpStackViewConstraints()
        
        
//        // Create the bottom line
//        let bottomLine = CALayer()
//
//        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
//
//        bottomLine.backgroundColor = UIColor.init(red: 23/255, green: 123/255, blue: 174/255, alpha: 1).cgColor
//
//        // Remove border on text field
//        textfield.borderStyle = .none
//
//        // Add the line to the text field
//        textfield.layer.addSublayer(bottomLine)
//
//
//        textfield.returnKeyType = .next
        
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleSecureTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
}

extension LoginView{
    
    
    private func setUpEmailTextFieldConstraints(){
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //                emailTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            //                emailTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            //                emailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            //                emailTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
    private func setUpPasswordTextFieldConstraints(){
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //                passwordTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            //                passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            //                passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            //                passwordTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    private func setUpLoginButtonConstraints(){
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //                loginButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            //                loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            //                loginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            //                loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        
    }
    
    private func setUpErrorLabelContraints(){
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //            NSLayoutConstraint.activate([
        //
        //                errorLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        //                errorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        //                errorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        //                errorLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        //            ])
    }
    
    private func setUpStackViewConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
        ])
    }
    
    
}


