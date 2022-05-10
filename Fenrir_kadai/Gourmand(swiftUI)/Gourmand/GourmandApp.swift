//
//  GourmandApp.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/04/29.
//

import SwiftUI

@main
struct GourmandApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
