import SwiftUI

@main
struct VulnApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State var status = "منتظر ورود..."
    
    var body: some View {
        VStack {
            Text(status).padding()
            Button("تست ورود") {
                if checkPassword("wrong_pass") {
                    status = "دسترسی باز شد! (آسیب‌پذیر)"
                } else {
                    status = "دسترسی رد شد!"
                }
            }
        }
    }
    
    // این همان تابعی است که می‌خواهیم با فریدا دور بزنیم
    func checkPassword(_ pass: String) -> Bool {
        return pass == "1234"
    }
}
