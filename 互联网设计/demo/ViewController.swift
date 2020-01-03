
import UIKit

let APP_FRAME = UIScreen.main.bounds
// 登录页面
class ViewController: UIViewController {

    var CoverImageView = UIImageView()
    var UserNameTextField = UITextField()
    var PasswordTextField = UITextField()
    var SignInButton = UIButton()
    var TipsLabel = UILabel()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    var UserName: String = ""
    var Password: String = ""
    
    // 默认账户
    var vaildName: String = "Sincere"
    var vaildPass: String = "123456"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        self.SetupUI()
    }
    
    func SetupUI(){
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        self.view.addSubview(CoverImageView)
        let CoverImageRadius = 200 as CGFloat
        CoverImageView.translatesAutoresizingMaskIntoConstraints = false
        CoverImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        CoverImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        CoverImageView.widthAnchor.constraint(equalToConstant: CoverImageRadius).isActive = true
        CoverImageView.heightAnchor.constraint(equalToConstant: CoverImageRadius).isActive = true
        CoverImageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        CoverImageView.layer.cornerRadius = CoverImageRadius/2
        CoverImageView.layer.masksToBounds = true
        
        self.view.addSubview(UserNameTextField)
        UserNameTextField.translatesAutoresizingMaskIntoConstraints = false
        UserNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        UserNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        UserNameTextField.topAnchor.constraint(equalTo: CoverImageView.bottomAnchor, constant: 100).isActive = true
        UserNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        UserNameTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UserNameTextField.layer.cornerRadius = 5
        UserNameTextField.layer.masksToBounds = true
        UserNameTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        UserNameTextField.adjustsFontSizeToFitWidth = true
        UserNameTextField.clearButtonMode = .whileEditing
        UserNameTextField.delegate = self
        UserNameTextField.returnKeyType = .done
        UserNameTextField.font = .systemFont(ofSize: 18)
        UserNameTextField.textAlignment = .center

        self.view.addSubview(PasswordTextField)
        PasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        PasswordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        PasswordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        PasswordTextField.topAnchor.constraint(equalTo: UserNameTextField.bottomAnchor, constant: 20).isActive = true
        PasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        PasswordTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        PasswordTextField.layer.cornerRadius = 5
        PasswordTextField.layer.masksToBounds = true
        PasswordTextField.adjustsFontSizeToFitWidth = true
        PasswordTextField.clearButtonMode = .whileEditing
        PasswordTextField.isSecureTextEntry = true
        PasswordTextField.delegate = self
        PasswordTextField.returnKeyType = .done
        PasswordTextField.font = .systemFont(ofSize: 18)
        PasswordTextField.textAlignment = .center
        
        
        self.view.addSubview(SignInButton)
        SignInButton.translatesAutoresizingMaskIntoConstraints = false
        SignInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 130).isActive = true
        SignInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -130).isActive = true
        SignInButton.topAnchor.constraint(equalTo: PasswordTextField.bottomAnchor, constant: 40).isActive = true
        SignInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        SignInButton.layer.cornerRadius = 15
        SignInButton.layer.masksToBounds = true
        SignInButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.6906035959)
        SignInButton.setTitle("登录", for: .normal)
        SignInButton.addTarget(self, action: #selector(loginButtonDidTouch), for: .touchDown)
        

        self.view.addSubview(TipsLabel)
        TipsLabel.translatesAutoresizingMaskIntoConstraints = false
        TipsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        TipsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        TipsLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        TipsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        TipsLabel.textAlignment = .center
        TipsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        TipsLabel.text = "欢迎使用~"
        
    }
    
    func alertShow(info: String){
        let cancelAlertController = UIAlertController(title: "提示",
        message: info,
        preferredStyle: .alert)
        let Cancel = UIAlertAction(title: "好的", style: UIAlertAction.Style.cancel) { (UIAlertAction) -> Void in
        }
        cancelAlertController.addAction(Cancel)
        self.present(cancelAlertController, animated: true, completion: nil)
    }
    
    @objc func loginButtonDidTouch(){
        UserNameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
//        // test
//        let heartVC = HeartViewController()
//        heartVC.modalPresentationStyle = .fullScreen
//        PasswordTextField.text = nil
//        self.present(heartVC, animated: true){}
        
        if !UserName.isEmpty{
            /*
            这里添加User Name 和 Password的匹配
            */
            if UserName != vaildName{
                alertShow(info: "该用户不存在")
            }
            else{
                if Password.isEmpty{
                    alertShow(info: "密码不能为空")
                }else{
                    if Password != vaildPass{
                        alertShow(info: "密码错误")
                    }else{
                        let heartVC = HeartViewController()
                        heartVC.modalPresentationStyle = .fullScreen
                        PasswordTextField.text = nil
                        self.present(heartVC, animated: true){}
                    }
                }
            }
        }
        else{
            alertShow(info: "用户名不能为空")
        }
    }
}


extension ViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == UserNameTextField{
            UserName = UserNameTextField.text!
            if UserName == vaildName {
                CoverImageView.image = UIImage(named: "user.JPG")
                self.view.backgroundColor = .init(patternImage: UIImage(named: "user.JPG")!)
                blurView.removeFromSuperview()
                self.view.addSubview(blurView)
                self.view.sendSubviewToBack(blurView)
            }
        }
        if textField == PasswordTextField{
            Password = PasswordTextField.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == UserNameTextField{
            UserNameTextField.resignFirstResponder()
        }
        if textField == PasswordTextField{
            PasswordTextField.resignFirstResponder()
        }
        return true
    }
}
