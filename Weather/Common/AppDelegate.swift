import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let generalViewController = makeGeneralViewController()
        let viewController = UINavigationController(rootViewController: generalViewController)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()

        return true
    }
}

extension AppDelegate {
    func makeGeneralViewController() -> GeneralViewController {
        let presenter = GeneralPresenter()
        let controller = GeneralViewController(presenter: presenter)
        presenter.setView(view: controller)
        return controller
    }
}

