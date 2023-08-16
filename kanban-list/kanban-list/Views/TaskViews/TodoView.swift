//
//  TodoView.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

struct TodoView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    @EnvironmentObject var appData: ApplicationData
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                TaskView(tasks: appData.todo)
            }
            .navigationTitle("Todo")
            .frame(maxWidth: .infinity)
            .background(Material.ultraThinMaterial)
            .contentShape(Rectangle())
            .dropDestination(for: String.self) { items, location in
                withAnimation(.spring()) {
                    appData.moveTaskAcrossList(.todo)
                }
                return true
            } isTargeted: { _ in }
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
