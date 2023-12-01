//
//  BombNewsApp.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import SwiftUI

@main
struct BombNewsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NewsListView()
            }
        }
    }
}
