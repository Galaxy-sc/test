import UIKit
import Darwin // اضافه شدن برای دسترسی به توابع C مثل dlopen

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // --- بارگذاری خودکار Frida Gadget ---
        if let gadgetPath = Bundle.main.path(forResource: "FridaGadget", ofType: "dylib") {
            let handle = dlopen(gadgetPath, RTLD_NOW)
            if handle != nil {
                print("[+] Frida Gadget Loaded Successfully at Runtime!")
            } else {
                print("[-] Failed to load Frida Gadget.")
            }
        } else {
            print("[-] FridaGadget.dylib not found in bundle.")
        }
        // -------------------------------------

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
