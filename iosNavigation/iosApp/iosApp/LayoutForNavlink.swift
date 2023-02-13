import SwiftUI
import common

func layoutFor(_ navLink: NavLink, navController: NavController) -> AnyView {
    let destination: any View
    switch navLink {
    case NavLink.first: destination = FirstScreen(viewmodel: FirstViewModel(navController: navController))
    case NavLink.second: destination = SecondScreen(viewmodel: SecondViewModel(navController: navController))
    case NavLink.third: destination = ThirdScreen(viewmodel: ThirdViewModel(navController: navController))
    default: fatalError("navlink unknown")
    }
    return AnyView(destination)
}
