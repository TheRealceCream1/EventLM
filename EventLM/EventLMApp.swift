//EventLM
//
//  Created by Owen Bress (student LM) on 2/24/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct EventLM: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var path : Path = Path()
    @StateObject var isData : getData = getData()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(path)
                .environmentObject(isData)

        }
    }
}

