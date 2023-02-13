import SwiftUI
import common

struct NavigatingView: View {
    @State var pushDestination: NavLink? = nil
    @State var modalDestination: NavLink? = nil
    @Environment(\.presentationMode) var presentationMode

    @State var parentPopTo: (NavLink) -> Void
    @State var currentNavLink: NavLink
    @State var content: (NavController) -> AnyView
    
    private var navController: some NavController {
        IOSNavController(navigatingView: self)
    }

    var body: some View {
        VStack {
            content(navController)
            NavigationLink(
                "",
                isActive: .init(
                    get: { pushDestination != nil },
                    set: { _ in pushDestination = nil }
                ),
                destination: {
                    if let dest = pushDestination {
                        NavigatingView(
                            parentPopTo: { navController.popTo(navLink: $0) },
                            currentNavLink: dest,
                            content: { childNavController in
                                layoutFor(dest, navController: childNavController)
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
                        NavigatingView(
                            parentPopTo: { navController.popTo(navLink: $0) },
                            currentNavLink: dest,
                            content: { childNavController in
                                layoutFor(dest, navController: childNavController)
                            }
                        )
                    }
                }
            }
        )
    }
}
