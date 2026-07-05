import UIKit
import Darwin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // --- لود کردن فریدا از داخل فریم‌ورک مبدل ---
        if let frameworksPath = Bundle.main.privateFrameworksPath {
            // آدرس آپدیت شد:
            let gadgetPath = frameworksPath + "/FridaGadget.framework/FridaGadget"
            let handle = dlopen(gadgetPath, RTLD_NOW)
            
            if handle != nil {
                print("[+] Frida Gadget Framework Loaded Successfully!")
            } else {
                print("[-] Failed to load Frida Gadget Framework.")
            }
        }
        // ---------------------------------------------

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
