import SwiftUI
import common

struct ThirdScreen: View {
    @State var viewmodel: ThirdViewModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("3!")
            Button("Click me to go back to 1!", action: { viewmodel.onClick() })
        }
        .padding()
    }
}
