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
    var user: User!
    var isCurrentUser = false
    
    //MARK: VIEWS
    lazy var userName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Username: Demo"
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        return label
    }()
    
    lazy var logOutButton: UIButton = {
        var button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
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
        guard let userID = FirebaseAuthService.manager.currentUser?.uid else { return }
        FirestoreService.manager.getUserInfo(userID: userID) { (result) in
            switch result {
            case .success(let userInfo):
                self.userName.text = userInfo.userName
            case .failure(let error):
                print(error)
            }
        }
    }

    
    //MARK: CONSTRAINTS
    private func setConstraints() {
        constrainUserName()
        setUserName()
        constrainLogOutButton()
    }

    
    private func constrainUserName() {
        view.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            userName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            userName.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: 1.5),
            userName.heightAnchor.constraint(equalToConstant: 70)])
    }
    
    private func constrainLogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
            logOutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 30)
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
    

    
}
