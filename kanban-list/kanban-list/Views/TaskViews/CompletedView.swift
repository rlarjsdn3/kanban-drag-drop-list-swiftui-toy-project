//
//  CompletedView.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

struct CompletedView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    @EnvironmentObject var appData: ApplicationData
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                TaskView(tasks: appData.completed)
            }
            .navigationTitle("Completed")
            .frame(maxWidth: .infinity)
            .background(Material.ultraThinMaterial)
            .contentShape(Rectangle())
            .dropDestination(for: String.self) { items, location in
                withAnimation(.spring()) {
                    appData.moveTaskAcrossList(.completed)
                }
                return true
            } isTargeted: { _ in }
        }
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView()
            .environmentObject(ApplicationData())
    }
}
