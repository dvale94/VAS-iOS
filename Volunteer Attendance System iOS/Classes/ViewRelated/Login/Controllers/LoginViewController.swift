//
//  LoginViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 10/13/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .whiteLarge
        indicator.color = .gciBlue
        indicator.center = self.view.center
        return indicator
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 24
        return stackView
    }()
    
    private var emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Username"
        textField.title = "Username"
        return textField
    }()
    
    private var passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Password"
        textField.title = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var loginButton: LoadingButton = {
        let button = LoadingButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }

}

// MARK: - View Configurations

extension LoginViewController {
    
    private func setupView() {
        
        view.backgroundColor = .white
        setupStackView()
        configureConstraints()
        setFieldHandlers()
        
    }
    
    private func setFieldHandlers() {
        emailTextField.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(handleLogin(_:)), for: .touchUpInside)
    }
    
    private func setupStackView() {
        
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(loginButton)
        view.addSubview(verticalStackView)
        
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: view.leadingAnchor, multiplier: 8),
            verticalStackView.trailingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: view.trailingAnchor, multiplier: 8),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
        ])
        
    }
    
}

// MARK: - Validation and Error Handling

extension LoginViewController {
    
    @objc func handleTextFieldDidChange(_ sender: UITextField) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            loginButton.isEnabled = false
        } else {
            loginButton.isEnabled = true
        }
    }
    
    @objc func handleLogin(_ sender: UIButton) {
        handleValidation()
    }
    
    private func handleValidation() {
        do {
            let username = try emailTextField.validate(ValidationType.requiredField(field: "username"))
            let password = try passwordTextField.validate(ValidationType.password)
            handleUserLogin(username: username, password: password)
        } catch (let error) {
            print((error as! ValidationError).errMessage)
        }
    }
    
    private func handleError(_ alert: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func handleUserLogin(username: String, password: String) {
        loginButton.showLoading()
        NetworkManager.shared.loginUser(username: username, password: password) { user, error in
            if let loggedUser = user {
                DispatchQueue.main.async {
                    let defaults = UserDefaults.standard
                    defaults.set(try? PropertyListEncoder().encode(loggedUser), forKey: "currentUser")
                    defaults.set(true, forKey: "isUserLoggedIn")
                    defaults.synchronize()
                    let homeViewController = MainTabBarController(showAdminView: AppDelegate.isUserAdmin)
                    homeViewController.modalPresentationStyle = .overCurrentContext
                    self.present(homeViewController, animated: true, completion: nil)
                }
            } else {
                self.handleError("The username or password you entered is incorrect")
            }
        }
    }
    
}
