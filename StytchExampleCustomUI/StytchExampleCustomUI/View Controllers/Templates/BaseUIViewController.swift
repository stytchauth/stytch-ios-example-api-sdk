import UIKit
import SnapKit
import Stytch

class BaseUIViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        var image = UIImageView(image: UIImage(named: "background_image"))
        image.backgroundColor = .red
        return image
    }()
    
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Your socks are excited...",
                                                  attributes: [:])
        label.font = UIFont(name: "Optima-Bold", size: 27)
        label.textAlignment = .center
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        let paragrpahStyle = NSMutableParagraphStyle()
        paragrpahStyle.lineSpacing = 3.4
        label.attributedText = NSAttributedString(string: "Sign up or log in to place the order.\nNo Password required!",
                                                  attributes: [NSAttributedString.Key.paragraphStyle:paragrpahStyle])
        label.font = UIFont(name: "Optima", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    let bottomText: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Didn't find it? ",
                                                                                      attributes: [NSAttributedString.Key.font : UIFont(name: "Optima", size: 18)!])
        attributedString.append(NSAttributedString(string: "Send it again.", attributes: [NSAttributedString.Key.font : UIFont(name: "Optima-Bold", size: 18)!]))
        label.attributedText = attributedString
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.isHidden = true
        
        return label
    }()
    
    let textbox: UITextField = {
        let textView = UITextField()
        //I need a placeholder text here
        //I also need to add the black border to it
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.defaultTextAttributes = [NSAttributedString.Key.font:UIFont(name: "Optima", size: 16)!]
        textView.placeholder = "example@gmail.com"
        
        let leftInsetView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 9.0, height: 2.0))
        textView.leftView = leftInsetView
        textView.leftViewMode = .always
        textView.returnKeyType = .done
        return textView
    }()
    
    public let goButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "right_arrow_button"), for: .normal)
        return button
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .black
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }

    
    func setUpView(){
        view.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints{
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        view.addSubview(centerView)
        
        centerView.snp.makeConstraints{
            $0.width.equalToSuperview().inset(10)
            $0.height.equalToSuperview().dividedBy(2.25)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.85)
        }
        
        centerView.addSubview(mainLabel)
        
        (mainLabel).snp.makeConstraints{
            $0.centerX.equalToSuperview()
        }
        
        
        centerView.addSubview(subtitleLabel)
        
        (subtitleLabel).snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.top.equalTo(mainLabel.snp.bottom).offset(29)
            $0.width.equalToSuperview().inset(60)
        }
        
        textbox.delegate = self
        textbox.snp.makeConstraints{
            $0.width.equalTo(233)
            $0.height.equalTo(40)
        }
        
        let stackView = UIStackView(arrangedSubviews: [bottomText, textbox, goButton])
        stackView.spacing = 10
        stackView.alignment = .center
        
        centerView.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(35)
        }
        
        
        centerView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stackView.snp.bottom).offset(15)
        }
        
    }
    
    func setUpNavigationBar(){
       self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        
        let shoppingIcon = UIBarButtonItem(image: UIImage(named: "shopping_bag")?.withRenderingMode(.alwaysOriginal),
                                           style: .plain,
                                           target: nil,
                                           action: nil)
        let personIcon = UIBarButtonItem(image: UIImage(named: "person")?.withRenderingMode(.alwaysOriginal),
                                           style: .plain,
                                           target: nil,
                                           action: nil)
        self.navigationItem.setRightBarButtonItems([shoppingIcon, personIcon], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension BaseUIViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
