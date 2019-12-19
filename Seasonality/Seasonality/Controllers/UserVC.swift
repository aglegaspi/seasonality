//
//  UserVC.swift
//  Seasonality
//
//  Created by Alex 6.1 on 12/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//
import Foundation
import UIKit
import FirebaseAuth

class UserVC: UIViewController {
    
    //MARK: PROPERTIES
    //var user: AppUser!
    var isCurrentUser = false
    var imageURL: String? = nil
    
    
    //MARK: VIEWS
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.tintColor = .orange
        button.backgroundColor = .init(white: 0.4, alpha: 0.8)
        button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        return button
    }()
    
    lazy var logOutButton: UIButton = {
        var button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchDown)
        return button
    }()
    
    
    //MARK: LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.000, green: 0.755, blue: 1.000, alpha: 1.0)
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUserName()
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func setUserName() {
//        if let displayName = FirebaseAuthService.manager.currentUser?.displayName {
//            userName.text = displayName
//        }
    }

    
    //MARK: CONSTRAINTS
    private func setConstraints() {
        constrainUserName()
        constrainEditButton()
        setUserName()
        constrainLogOutButton()
    }

    
    private func constrainUserName() {
        view.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            userName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            userName.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: 1.5),
            userName.heightAnchor.constraint(equalToConstant: 70)])
    }
    
    private func constrainEditButton() {
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.heightAnchor.constraint(equalToConstant: 30),
            editButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            editButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func constrainLogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            logOutButton.heightAnchor.constraint(equalToConstant: 30),
            logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)
            
        ])
    }
    
    
    //MARK: OBJC FUNCTIONS
    @objc func logOutButtonPressed() {
        do {
            try Auth.auth().signOut()
            present(ShowAlert.prompt(with: "Signed Out!", and: "See You Soon."), animated: true, completion: nil)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else { return }
            
            UIView.transition(with: window, duration: 1.0, options: .transitionFlipFromBottom, animations: {
                window.rootViewController = {
                    
                    let storyboard  = UIStoryboard(name: "Main", bundle: nil)
                    guard let welcomeVC = storyboard.instantiateViewController(withIdentifier: "welcomeVC") as? WelcomeViewController else { return UIViewController() }
                   return welcomeVC
                }()
            }, completion: nil)
            
        } catch {
            print(error)
        }
    }
    
    @objc private func editAction(){
//        let editVC = EditProfileVC()
//        editVC.modalPresentationStyle = .fullScreen
//        present(editVC, animated: true, completion: nil)
    }
    
}
