import UIKit

class ViewController: UIUIViewController {

    // آسیب‌پذیری اول: Hardcoded Credentials
    // قرار دادن رمز عبور در سورس کد یکی از رایج‌ترین خطاهای امنیتی است.
    let secretAdminPassword = "SuperSecretPassword123!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // آسیب‌پذیری دوم: Insecure Data Storage
        // ذخیره اطلاعات حساس به صورت Plain Text در UserDefaults (که رمزنگاری نمی‌شود)
        let userDefaults = UserDefaults.standard
        userDefaults.set("User_Bank_Token_987654321", forKey: "SessionToken")
        userDefaults.set("admin_user", forKey: "Username")
        
        // شبیه‌سازی یک لاگین ساده
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
