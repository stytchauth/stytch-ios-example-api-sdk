
import UIKit
import Stytch

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    let stytchProjectID = "ProjectID"
    let stytchSecretKey = "SecretKey"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StytchMagicLink.shared.configure(projectID: stytchProjectID, secret: stytchSecretKey, scheme: "stytchappexamplecustomui", host: "stytch.com")
        StytchMagicLink.shared.environment = .test
        StytchMagicLink.shared.loginMethod = .loginOrInvite
        StytchMagicLink.shared.delegate = self
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = InitialViewController()
        let navigationController = UINavigationController(rootViewController: initialViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: Handling Various App Deep Linking
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return StytchMagicLink.shared.handleMagicLinkUrl(userActivity.webpageURL)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return StytchMagicLink.shared.handleMagicLinkUrl(url)
    }

}

extension AppDelegate: StytchMagicLinkDelegate {
    func onSuccess(_ result: StytchResult){
        let authedVC = LoggedInViewController()
        let navigationController = UINavigationController(rootViewController: authedVC)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        print("SUCCESS")
    }
    
    func onFailure(_ error: StytchError){
        //Handle failure
        print("Failture")
    }
}


