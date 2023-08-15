//
//  CompletedView.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

struct CompletedView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    @Binding var completed: [Task]
    @Binding var currentDragging: Task?
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                TaskView(tasks: completed, currentDragging: $currentDragging)
            }
            .navigationTitle("Completed")
            .frame(maxWidth: .infinity)
            .background(Material.ultraThinMaterial)
        }
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView(completed: .constant([]), currentDragging: .constant(nil))
    }
}
