import UIKit

class ViewController: UIViewController {

    // آسیب‌پذیری اول: وجود رمز عبور ادمین به صورت هاردکد در سورس کد
    let secretAdminPassword = "SuperSecretPassword123!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ایجاد یک متن ساده روی صفحه گوشی برای اطمینان از اجرای برنامه
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        label.center = view.center
        label.text = "Vulnerable App is Running"
        label.textAlignment = .center
        view.addSubview(label)
        
        // آسیب‌پذیری دوم: ذخیره اطلاعات حساس (توکن بانکی و نام کاربری) به صورت متن ساده در UserDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set("User_Bank_Token_987654321", forKey: "SessionToken")
        userDefaults.set("admin_user", forKey: "Username")
        
        // شبیه‌سازی متد لاگین
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
