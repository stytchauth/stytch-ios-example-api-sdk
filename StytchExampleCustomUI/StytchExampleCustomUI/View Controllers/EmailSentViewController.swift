import UIKit

class EmailSentViewController: BaseUIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeView()
    }
    
    func customizeView(){
        mainLabel.text = "You've got a mail!"
        subtitleLabel.text = "Check your inbox (including the Promotions folder) for the login link."
        bottomText.isHidden = false
        goButton.isHidden = true
        textbox.isHidden = true
        
        bottomText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedBottomText)))
    }
    
    @objc func tappedBottomText() {
        self.navigationController?.popViewController(animated: true)
    }

}
