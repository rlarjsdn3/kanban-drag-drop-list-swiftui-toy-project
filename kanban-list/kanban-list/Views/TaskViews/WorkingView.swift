//
//  WorkingView.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

struct WorkingView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    @Binding var working: [Task]
    @Binding var currentDragging: Task?
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                TaskView(tasks: working, currentDragging: $currentDragging)
            }
            .navigationTitle("Working")
            .frame(maxWidth: .infinity)
            .background(Material.ultraThinMaterial)
        }
    }
}

struct WorkingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkingView(working: .constant([]), currentDragging: .constant(nil))
    }
}
