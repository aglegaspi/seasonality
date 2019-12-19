//
//  SignUpViewController.swift
//  Seasonality
//
//  Created by Jack Wong on 12/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    let signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signUpView)
        hideKeyboardWhenTappedAround()
        //not dealing with error label for the time being
        signUpView.errorLabel.alpha = 0
    
        signUpView.emailTextField.delegate = self
        signUpView.nameTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        
        signUpView.signUpButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonTapped(){
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            print("Input error")
            // There's something wrong with the fields, show error message
//            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let name = signUpView.nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = signUpView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = signUpView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    if let err = err{
                        self.showError(err.localizedDescription)
                    }
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    let userUUID = result!.user.uid
                    
                    let userCollectionDocReference = db.collection("users").document(userUUID)
       
                    
                    userCollectionDocReference.setData(["name": name, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                           print("error adding user data")
                        }
                    }
                    self.showError("Success!")
                    let mainTBC = MainTBC()
                    mainTBC.modalPresentationStyle = .fullScreen
                    self.present(mainTBC,animated: true)
                }
            }
        }
    }
    

    
     private func showError(_ message:String) {
         
        signUpView.errorLabel.text = message
        signUpView.errorLabel.alpha = 1
     }
    
    
    private func validateFields() -> String? {
        
        // Check that all fields are filled in
        if signUpView.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            
             signUpView.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             signUpView.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if email is valid
        let sanitizedEmail = signUpView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isEmailValid(sanitizedEmail) == false {
            return "Please enter a valid email"
        }
        
        
        // Check if the password is secure
        let sanitizedPassword = signUpView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(sanitizedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }

}

extension SignUpViewController: UITextFieldDelegate{
    
}
