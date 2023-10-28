//
//  helloApp.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-10-13.
//

import SwiftUI

@main
struct helloApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
