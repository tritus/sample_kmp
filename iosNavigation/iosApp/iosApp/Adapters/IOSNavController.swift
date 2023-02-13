import common

class IOSNavController: NavController {
    let navigatingView: NavigatingView
    
    init(navigatingView: NavigatingView) {
        self.navigatingView = navigatingView
    }
    
    func popTo(navLink: NavLink) {
        if (navigatingView.currentNavLink == navLink) {
            navigatingView.pushDestination = nil
            navigatingView.modalDestination = nil
        } else {
            navigatingView.parentPopTo(navLink)
        }
    }
    
    func push(navLink: NavLink) {
        navigatingView.pushDestination = navLink
    }
    
    func pop() {
        navigatingView.presentationMode.wrappedValue.dismiss()
    }
    
    func pushModal(navLink: NavLink) {
        navigatingView.modalDestination = navLink
    }
}
