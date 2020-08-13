//
//  LoginVC.swift
//  Uber-Clone-iOS
//
//  Created by rs on 13.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    private lazy var emailContainer: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private lazy var passwordContainer: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private var emailTextField: UITextField = {
        return UITextField().textField(placeholder: "Email")
    }()
    
    private var passwordTextField: UITextField = {
        return UITextField().textField(placeholder: "Password", isSecure: true)
    }()
    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Don't have an account yet? ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        title.append(NSAttributedString(string: "Sign Up!", attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.blueTint]))
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureUI()
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainer, passwordContainer, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .equalSpacing
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, topPadding: 40, rightPadding: 16, leftPadding: 16)
        
        view.addSubview(registerButton)
        registerButton.anchor(right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, rightPadding: 16, bottomPadding: 16, leftPadding: 16, height: 44)
    }
    
    // MARK: - Selectors
    
    @objc func registerPressed() {
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func loginPressed() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                let ac = UIAlertController(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(ac, animated: true)
                return
            }
            
            print("Login was successful")
        }
    }
    
}
