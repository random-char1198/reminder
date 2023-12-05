//
//  helloApp.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-10-13.
//

import SwiftUI

@main
struct helloApp: App {
    init() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
            print("Deleted")
        }
    }
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
