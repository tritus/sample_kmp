import SwiftUI
import common

struct SecondScreen: View {
    @State var viewmodel: SecondViewModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("2!")
            Button("Click me to go to 3!", action: { viewmodel.onClick() })
            Button("Click me to go back", action: { viewmodel.onGoBackClicked() })
        }
        .padding()
    }
}
