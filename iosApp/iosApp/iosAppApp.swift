import SwiftUI
import common

@main
struct iosAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView(
                content: {
                    ElectraView(
                        content: { navController in
                            destinationFor(AppConstants.shared.rootScreen, navController: navController)
                        }
                    )
                }
            )
        }
    }
}

struct ElectraView: View {
    @State var destination: NavLink? = nil
    @Environment(\.presentationMode) var presentationMode

    let content: (NavController) -> AnyView

    var body: some View {
        let navController = IOSNavController(
            onPush: { dest in destination = dest },
            onPopTo: { _ in presentationMode.wrappedValue.dismiss() }
        )
        VStack {
            content(navController)
            NavigationLink(
                "",
                isActive: .init(
                    get: { destination != nil },
                    set: { _ in destination = nil }
                ),
                destination: {
                    if let dest = destination {
                        ElectraView(
                            content: { childNavController in
                                destinationFor(dest, navController: childNavController)
                            }
                        )
                    }
                }
            )
        }
    }
}

struct FirstScreen: View {
    private let viewmodel: FirstViewModel

    init(navController: NavController) {
        self.viewmodel = FirstViewModel(navController: navController)
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("1!")
            Button("Click me to go to 2!", action: { viewmodel.onCLick() })
        }
        .padding()
    }
}

struct SecondScreen: View {
    private let viewmodel: SecondViewModel

    init(navController: NavController) {
        self.viewmodel = SecondViewModel(navController: navController)
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("2!")
            Button("Click me to go to 3!", action: { viewmodel.onCLick() })
        }
        .padding()
    }
}

struct ThirdScreen: View {
    private let viewmodel: ThirdViewModel

    init(navController: NavController) {
        self.viewmodel = ThirdViewModel(navController: navController)
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("3!")
            Button("Click me to go back to 1!", action: { viewmodel.onCLick() })
        }
        .padding()
    }
}

class IOSNavController: NavController {
    let onPush: (NavLink) -> Void
    let onPopTo: (NavLink) -> Void
    
    init(onPush: @escaping (NavLink) -> Void, onPopTo: @escaping (NavLink) -> Void) {
        self.onPush = onPush
        self.onPopTo = onPopTo
    }
    
    func popTo(navLink: NavLink) {
        onPopTo(navLink)
    }
    
    func push(navLink: NavLink) {
        onPush(navLink)
    }
}

func destinationFor(_ navLink: NavLink, navController: NavController) -> AnyView {
    let destination: any View
    switch navLink {
    case NavLink.first: destination = FirstScreen(navController: navController)
    case NavLink.second: destination = SecondScreen(navController: navController)
    case NavLink.third: destination = ThirdScreen(navController: navController)
    default: fatalError("navlink unknown")
    }
    return AnyView(destination)
}
