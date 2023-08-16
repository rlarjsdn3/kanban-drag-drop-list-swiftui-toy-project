//
//  kanban_listApp.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

@main
struct kanban_listApp: App {
    
    // MARK: - WRAPPER PROPERTIES
    
    @StateObject var appData = ApplicationData()
    
    // MARK: - BODY
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
        }
    }
}
