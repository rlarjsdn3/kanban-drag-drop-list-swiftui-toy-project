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
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
