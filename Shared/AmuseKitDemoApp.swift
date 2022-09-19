//
//  AmuseKitDemoApp.swift
//  Shared
//
//  Created by Jota Uribe on 2/09/22.
//

import SwiftUI

@main
struct AmuseKitDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

extension MainView {
    init() {
        self.init(controller: .init(dataProvider: .shared(), mediaPlayer: .init()))
    }
}
