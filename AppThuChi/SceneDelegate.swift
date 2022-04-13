import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
        guard let windowSence = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowSence
        
        let loginVC = LoginViewController()
        //let homeVC = HomeViewController()

        let navigationC = UINavigationController(rootViewController: TabBarViewController())

        let isLogin = UserDefaults.standard.bool(forKey: "login")

        if isLogin {
            window?.rootViewController = navigationC
        } else {
            window?.rootViewController = loginVC
        }
        
        window?.makeKeyAndVisible()
    
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }


}

