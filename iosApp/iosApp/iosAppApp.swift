//
//  iosAppApp.swift
//  iosApp
//
//  Created by Tristan Ferré on 07/02/2023.
//

import SwiftUI
import common

@main
struct iosAppApp: App {
    var body: some Scene {
        WindowGroup {
            ElectraNavigationView(
                content: { navController in
                    AnyView(FirstScreen(navController: navController))
                }
            )
        }
    }
}

struct ElectraNavigationView: View {
    let content: (NavController) -> AnyView
    @State var destination: NavLink? = nil
    var body: some View {
        NavigationView(
            content: {
                let navController = IOSNavController(onPush: { destination = $0 }, onPop: { _ in})
                content(navController)
                if let navLink = destination {
                    NavigationLink(
                        "",
                        isActive: .init(get: { destination != nil }, set: { _ in }),
                        destination: {
                            ElectraNavigationView(
                                content: { childNavController in
                                    destinationFor(navLink, navController: childNavController)
                                }
                            )
                        }
                    )
                }
            }
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
    let onPop: (NavLink) -> Void
    
    init(onPush: @escaping (NavLink) -> Void, onPop: @escaping (NavLink) -> Void) {
        self.onPush = onPush
        self.onPop = onPop
    }
    
    func popTo(navLink: NavLink) {
        onPop(navLink)
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
    case NavLink.third: destination =  ThirdScreen(navController: navController)
    default: fatalError("navlink unknown")
    }
    return AnyView(destination)
}
