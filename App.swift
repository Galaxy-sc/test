import SwiftUI

@main
struct HelloWorldApp: App {
    var body: some Scene {
        WindowGroup {
            VStack {
                Text("Hello World!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Text("تست موفقیت‌آمیز روی آیفون ۷")
                    .font(.headline)
                    .padding(.top, 10)
            }
        }
    }
}
