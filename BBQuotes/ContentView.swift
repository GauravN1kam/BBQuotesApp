import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "tortoise") {
                Text("Breaking Bad View")
            }
            
            Tab("Better call saul", systemImage: "briefcase") {
                Text("Better call saul View")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
