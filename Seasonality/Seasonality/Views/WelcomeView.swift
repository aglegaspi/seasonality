
import UIKit


class WelcomeView:UIView {
    
    
    public lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    
    public lazy var signUpButton: UIButton = {
           let button = UIButton()
           button.setTitle("SignUp", for: .normal)
           return button
       }()
    
    public lazy var stackView: UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [loginButton, signUpButton])
        
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
    
        addSubview(loginButton)
        addSubview(signUpButton)

        setUpLoginButtonConstraints()

        setUpStackViewConstraints()

        Utilities.styleFilledButton(loginButton)
        Utilities.styleFilledButton(signUpButton)

    }
    
}

extension WelcomeView{
    

    
    private func setUpLoginButtonConstraints(){
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        
    }
    
    
    private func setUpSignUpButtonConstraints(){
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        
    }
 
    
    private func setUpStackViewConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 40)
            
            
        ])
    }
    
    
}


