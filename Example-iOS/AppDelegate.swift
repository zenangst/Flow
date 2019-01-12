import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle")?.load()
        #endif

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .groupTableViewBackground
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

private extension AppDelegate {

    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}
