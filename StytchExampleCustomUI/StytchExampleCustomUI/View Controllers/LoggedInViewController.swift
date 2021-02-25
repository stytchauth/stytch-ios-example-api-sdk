import UIKit

class LoggedInViewController: BaseUIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeView()
    }
    
    func customizeView(){
        mainLabel.text = "Enjoy your socks!"
        subtitleLabel.text = "CWe'll see you next time."
        bottomText.isHidden = false
        bottomText.attributedText = NSAttributedString(string: "Continue shopping", attributes: [NSAttributedString.Key.font : UIFont(name: "Optima-Bold", size: 18)!])
        goButton.isHidden = false
        textbox.isHidden = true
    }
}

