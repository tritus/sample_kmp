import SwiftUI
import common

@main
struct iosAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ElectraView(
                    parentPopTo: {_ in},
                    currentNavLink: AppConstants.shared.rootScreen,
                    content: { navController in
                        destinationFor(AppConstants.shared.rootScreen, navController: navController)
                    }
                )
            }
        }
    }
}

struct ElectraView: View {
    @State var pushDestination: NavLink? = nil
    @State var modalDestination: NavLink? = nil
    @Environment(\.presentationMode) var presentationMode

    let parentPopTo: (NavLink) -> Void
    let currentNavLink: NavLink
    let content: (NavController) -> AnyView

    var body: some View {
        VStack {
            content(getANavController())
            NavigationLink(
                "",
                isActive: .init(
                    get: { pushDestination != nil },
                    set: { _ in pushDestination = nil }
                ),
                destination: {
                    if let dest = pushDestination {
                        ElectraView(
                            parentPopTo: { getANavController().popTo(navLink: $0) },
                            currentNavLink: dest,
                            content: { childNavController in
                                destinationFor(dest, navController: childNavController)
                            }
                        )
                    }
                }
            )
        }
        .fullScreenCover(
            isPresented: .init(
                get: { modalDestination != nil },
                set: { _ in modalDestination = nil }
            ),
            onDismiss: {},
            content: {
                if let dest = modalDestination {
                    NavigationView {
                        ElectraView(
                            parentPopTo: { getANavController().popTo(navLink: $0) },
                            currentNavLink: dest,
                            content: { childNavController in
                                destinationFor(dest, navController: childNavController)
                            }
                        )
                    }
                }
            }
        )
    }
    
    func getANavController() -> NavController {
        return IOSNavController(
            onPush: { dest in pushDestination = dest },
            onPushModaly: { dest in modalDestination = dest },
            onPopTo: { dest in
                if (currentNavLink == dest) {
                    pushDestination = nil
                    modalDestination = nil
                } else {
                    parentPopTo(dest)
                }
            },
            onPop: { presentationMode.wrappedValue.dismiss() }
        )
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
            Button("Click me to go to 2 modally!", action: { viewmodel.onOpenSecondWithModalClicked() })
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
            Button("Click me to go back", action: { viewmodel.onGoBackClicked() })
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
    let onPushModaly: (NavLink) -> Void
    let onPopTo: (NavLink) -> Void
    let onPop: () -> Void
    
    init(
        onPush: @escaping (NavLink) -> Void,
        onPushModaly: @escaping (NavLink) -> Void,
        onPopTo: @escaping (NavLink) -> Void,
        onPop: @escaping () -> Void
    ) {
        self.onPush = onPush
        self.onPushModaly = onPushModaly
        self.onPopTo = onPopTo
        self.onPop = onPop
    }
    
    func popTo(navLink: NavLink) {
        onPopTo(navLink)
    }
    
    func push(navLink: NavLink) {
        onPush(navLink)
    }
    
    func pop() {
        onPop()
    }
    
    func pushModaly(navLink: NavLink) {
        onPushModaly(navLink)
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
