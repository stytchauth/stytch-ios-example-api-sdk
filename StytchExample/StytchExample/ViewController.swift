//
//  ViewController.swift
//  StytchExample
//
//  Created by Edgar Kroman on 2020-12-08.
//

import UIKit
import Stytch

class ViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Enter an email"
        return label
    }()
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.font = UIFont.systemFont(ofSize: 16)
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
        field.placeholder = "example@email.com"
        return field
    }()

    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send Magic Link", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Stytch.shared.delegate = self
        Stytch.shared.environment = .test
    
        setupViews()
    }

    @objc func handleSend() {
        Stytch.shared.login(email: textField.text ?? "")
        // Show loading
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(sendButton)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
            
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        
        sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: StytchDelegate {
    
    func onSuccess(_ result: StytchResult) {
        showAlert(title: "Success", message: "Request ID: \(result.requestId)\nUser ID: \(result.userId)")
    }
    
    func onFailure(_ error: StytchError) {
        
        var message: String = ""
        
        switch error {
        case .unknown:
            message = "Something went wrong"
        case .invalidEmail:
            message = "Invalid email"
        case .connection:
            message = "Could not connect to server"
        case .invalidMagicToken:
            message = "Magic link could not be authenticated"
        case .invalidConfiguration:
            message = "Something went wrong"
        }
        
        showAlert(title: "Error!", message: message)
    }
    
    func onMagicLinkSent(_ email: String) {
        // Change design if needed
    }
    
    func onDeepLinkHandled() {
        // Show loading
    }
    
}
