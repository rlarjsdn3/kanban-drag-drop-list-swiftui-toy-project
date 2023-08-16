//
//  ContentView.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - WRAPPER PROPERTIES

    @EnvironmentObject var appData: ApplicationData
    
    // MARK: - BODY
    
    var body: some View {
        HStack(spacing: 2) {
            TodoView()
            
            WorkingView()
            
            CompletedView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ApplicationData())
    }
}
