import SwiftUI
import common

struct ObservingView<ViewState>: View {
    @State var stateFlow: Kotlinx_coroutines_coreStateFlow
    @State var state: ViewState? = nil
    @State var observingTask: Task = Task {}
    @State var content: (ViewState) -> any View
    
    var body: some View {
        VStack {
            if let currentState = state {
                AnyView(content(currentState))
            }
        }
        .onAppear {
            observingTask.cancel()
            observingTask = Task {
                try? await stateFlow.collect(collector: FlowCollector(onEach: { state = $0 }))
            }
        }
        .onDisappear { observingTask.cancel() }
    }
}
