import common

class FlowCollector<Data>: Kotlinx_coroutines_coreFlowCollector {
    let onEach: (Data) -> Void
    
    init(onEach: @escaping (Data) -> Void) {
        self.onEach = onEach
    }

    func emit(value: Any?) async throws {
        onEach(value as! Data)
    }
}
