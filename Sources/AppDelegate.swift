import UIKit
import Darwin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // --- پیدا کردن و لود کردن فریدا از پوشه Frameworks ---
        if let frameworksPath = Bundle.main.privateFrameworksPath {
            let gadgetPath = frameworksPath + "/FridaGadget.dylib"
            let handle = dlopen(gadgetPath, RTLD_NOW)
            
            if handle != nil {
                print("[+] Frida Gadget Loaded Successfully from Frameworks!")
            } else {
                print("[-] Failed to load Frida Gadget. AMFI blocked it or path is wrong.")
            }
        }
        // -----------------------------------------------------

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
