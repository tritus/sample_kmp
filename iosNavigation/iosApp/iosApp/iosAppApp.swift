import SwiftUI
import common

@main
struct iosAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NavigatingView(
                    parentPopTo: {_ in},
                    currentNavLink: AppConstants.shared.rootScreen,
                    content: { navController in
                        layoutFor(AppConstants.shared.rootScreen, navController: navController)
                    }
                )
            }
        }
    }
}
