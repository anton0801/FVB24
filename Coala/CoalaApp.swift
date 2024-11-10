import SwiftUI

@main
struct CoalaApp: App {
    
    @UIApplicationDelegateAdaptor(CoalaAppDelegate.self) var coalaAppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}


class CoalaAppDelegate: NSObject, UIApplicationDelegate {
    
    static var orientationLock = UIInterfaceOrientationMask.landscape
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return CoalaAppDelegate.orientationLock
    }
    
}
