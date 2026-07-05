import UIKit

class ViewController: UIViewController {

    let secretAdminPassword = "SuperSecretPassword123!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // تنظیم صریح رنگ پس‌زمینه به سفید
        view.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        label.center = view.center
        label.text = "Vulnerable App is Running"
        // تنظیم صریح رنگ متن به مشکی
        label.textColor = .black 
        label.textAlignment = .center
        view.addSubview(label)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set("User_Bank_Token_987654321", forKey: "SessionToken")
        userDefaults.set("admin_user", forKey: "Username")
        
        login(password: "WrongPassword")
        login(password: secretAdminPassword)
    }
    
    func login(password: String) {
        if password == secretAdminPassword {
            print("Login Successful! Welcome Admin.")
        } else {
            print("Login Failed!")
        }
    }
}
