import UIKit

class ViewController: UIViewController {

    // ساخت عناصر رابط کاربری (UI Elements)
    let titleLabel = UILabel()
    let usernameField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton(type: .system)
    let statusLabel = UILabel()

    // رمز و یوزرنیم هاردکد شده (آسیب‌پذیری)
    let hardcodedUser = "admin"
    let hardcodedPass = "SecretPass123"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // متدی برای رسم کردن ظاهر برنامه روی صفحه
    func setupUI() {
        view.backgroundColor = .white

        // تنظیمات متن عنوان
        titleLabel.frame = CGRect(x: 50, y: 100, width: view.bounds.width - 100, height: 40)
        titleLabel.text = "Admin Login Panel"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)

        // تنظیمات فیلد نام کاربری
        usernameField.frame = CGRect(x: 50, y: 180, width: view.bounds.width - 100, height: 40)
        usernameField.placeholder = "Enter Username"
        usernameField.borderStyle = .roundedRect
        usernameField.autocapitalizationType = .none
        usernameField.textColor = .black
        usernameField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(usernameField)

        // تنظیمات فیلد رمز عبور
        passwordField.frame = CGRect(x: 50, y: 240, width: view.bounds.width - 100, height: 40)
        passwordField.placeholder = "Enter Password"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true // پسورد را به صورت ستاره نشان می‌دهد
        passwordField.textColor = .black
        passwordField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(passwordField)

        // تنظیمات دکمه لاگین
        loginButton.frame = CGRect(x: 50, y: 310, width: view.bounds.width - 100, height: 50)
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 10
        // متصل کردن دکمه به تابعی که با کلیک اجرا می‌شود
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.addSubview(loginButton)

        // تنظیمات متن وضعیت (پیام موفقیت یا شکست)
        statusLabel.frame = CGRect(x: 50, y: 380, width: view.bounds.width - 100, height: 60)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 2
        statusLabel.textColor = .darkGray
        statusLabel.text = "Please enter your credentials."
        view.addSubview(statusLabel)
    }

    // این تابع با کلیک روی دکمه لاگین اجرا می‌شود
    @objc func loginTapped() {
        let user = usernameField.text ?? ""
        let pass = passwordField.text ?? ""

        // آسیب‌پذیری اول: هرچیزی که کاربر تایپ کند در UserDefaults ذخیره می‌شود!
        UserDefaults.standard.set(user, forKey: "LastAttemptUser")
        UserDefaults.standard.set(pass, forKey: "LastAttemptPass")

        // فراخوانی تابع چک کردن اطلاعات
        checkCredentials(username: user, password: pass)
    }

    // آسیب‌پذیری دوم: تابع اعتبارسنجی
    // نکته مهم: استفاده از objc dynamic@ باعث می‌شود این تابع از طریق ران‌تایم Objective-C 
    // در دسترس باشد و هوک کردن آن با فریدا به شدت راحت و پایدار شود!
    @objc dynamic func checkCredentials(username: String, password: String) {
        if username == hardcodedUser && password == hardcodedPass {
            statusLabel.text = "✅ Success! Welcome Admin."
            statusLabel.textColor = .systemGreen
        } else {
            statusLabel.text = "❌ Failed! Incorrect Credentials."
            statusLabel.textColor = .systemRed
        }
    }
}
