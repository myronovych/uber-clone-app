//
//  SignUpVC.swift
//  Uber-Clone-iOS
//
//  Created by rs on 13.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
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
    
    private lazy var fullNameContainer: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private lazy var passwordContainer: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private lazy var pickerContainer: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_account_box_white_2x"), segmentedControl: segmentedControl)
        view.anchor(height: 75)
        return view
    }()
    
    private var emailTextField: UITextField = {
        return UITextField().textField(placeholder: "Email")
    }()
    
    private var fullNameTextField: UITextField = {
        return UITextField().textField(placeholder: "Full name")
    }()
    
    private var passwordTextField: UITextField = {
        return UITextField().textField(placeholder: "Password", isSecure: true)
    }()
    
    private let signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Rider", "Driver"])
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
        
        return segmentedControl
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Already have account? ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray,
                                                                                             NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        title.append(NSAttributedString(string: "Sign In!", attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor : UIColor.blueTint]))
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
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
        
        let stack = UIStackView(arrangedSubviews: [emailContainer, fullNameContainer, passwordContainer, pickerContainer, signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .equalSpacing
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, topPadding: 40, rightPadding: 16, leftPadding: 16)
        
        view.addSubview(signInButton)
        signInButton.anchor(right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, rightPadding: 16, bottomPadding: 16, leftPadding: 16, height: 44)
    }
    
    // MARK: - Selectors
    
    @objc func signInPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func registerPressed() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let fullName = fullNameTextField.text else { return }
        let accountType = segmentedControl.selectedSegmentIndex
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                let ac = UIAlertController(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(ac, animated: true)
                print("Error occured while registering user \(error)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": email, "fullName": fullName, "accountType": accountType] as [String : Any]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { _, _ in
                print("Successfully created user")
            })
            let homeVC = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? HomeVC
            homeVC?.configureUI()
            self.dismiss(animated: true)
        }
    }
}
