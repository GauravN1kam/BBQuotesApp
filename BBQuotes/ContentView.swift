import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "tortoise") {
                QuoteView(show: "Breaking Bad")
            }
            
            Tab("Better call saul", systemImage: "briefcase") {
                QuoteView(show: "Better Call Saul")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
