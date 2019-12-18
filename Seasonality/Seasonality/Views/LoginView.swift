//
//  LoginView.swift
//  Seasonality
//
//  Created by Jack Wong on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginView: UIView {
    
    public lazy var emailTextField: UITextField = {
        
        let tf = UITextField()
        
        return tf
        
    }()
    
    public lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        
        return tf
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setUpEverything()
        }
        
        private func setUpEverything() {
            backgroundColor = .systemGray
            
            addSubview(emailTextField)
            addSubview(passwordTextField)
            
            setEmailTextContraints()
            setPasswordFieldConstraints()
        }

}

extension LoginView {
    
    private func setEmailTextContraints(){
        
    }
    
    private func setPasswordFieldConstraints(){
           
    }
    
    
}
