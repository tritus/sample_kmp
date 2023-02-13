import SwiftUI
import common

struct FirstScreen: View {
    @State var viewmodel: FirstViewModel
    
    var body: some View {
        ObservingView(stateFlow: viewmodel.state) { (state: Int) in
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("1!")
                Text("Increment: \(state)")
                Button("Click me to go to 2!", action: { viewmodel.onClick() })
                Button("Click me to go to 2 modally!", action: { viewmodel.onOpenSecondWithModalClicked() })
                Button("Click me to increment", action: { viewmodel.onIncrementClicked() })
            }
            .padding()
        }
    }
}
