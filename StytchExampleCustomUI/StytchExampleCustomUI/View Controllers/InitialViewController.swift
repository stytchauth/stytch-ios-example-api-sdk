import UIKit
import SnapKit
import Stytch

class InitialViewController: BaseUIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view.
        goButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: UIButton) {
        guard let inputEmail = textbox.text else { return }
        textbox.resignFirstResponder()
        showLoading()
        StytchMagicLink.shared.login(email: inputEmail,
                                     success: { [weak self] email in
                                        self?.hideLoading()
                                        self?.presentConfirmationScreen(email)
                                     },
                                     failure: { [weak self] error in
                                        self?.hideLoading()
                                        self?.handleError(error)
                                     })
    }
    
    func presentConfirmationScreen(_ email: String){
        hideLoading()
        
        let sentVC = EmailSentViewController()
        self.navigationController?.pushViewController(sentVC, animated: true)
    }
    
    func handleError(_ error: StytchError){
        switch error{
        case .unknown:
            showAlert(title: "An Error Occured", message: "An unknown error has occured.")
        case .invalidEmail:
            showAlert(title: "An Error Occured", message: "Invalid Email")
        case .connection:
            showAlert(title: "An Error Occured", message: "Connection Issue")
        case .invalidMagicToken:
            showAlert(title: "An Error Occured", message: "Invalid Magic Token")
        case .invalidConfiguration:
            showAlert(title: "An Error Occured", message: "Invalid Configuration")
        }
    }
    
    func showLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}


