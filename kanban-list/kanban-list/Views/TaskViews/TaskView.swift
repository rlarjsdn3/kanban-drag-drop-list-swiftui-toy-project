//
//  TaskView.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

struct TaskView: View {
    
    // MARK: - PROPERTIES
    
    var tasks: [Task]
    
    // MARK: - WRAPPER PROPERTIES
    
    @Binding var currentDragging: Task?
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(tasks) { task in
                GeometryReader { geometry in
                    taskRow(task, size: geometry.size)
                }
                .frame(height: 45)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    // MARK: - FUNCTIONS
    
    @ViewBuilder
    func taskRow(_ task: Task, size: CGSize) -> some View {
        Text(task.title)
            .font(.caption)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: size.height)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
            .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 10))
            .draggable(task.id.uuidString) {
                Text(task.title)
                    .font(.caption)
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: size.height)
                    .background(Color.white)
                    .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 10))
                    .onAppear {
                        currentDragging = task
                    }
            }
            .dropDestination(for: String.self) { items, location in
                currentDragging = nil
                return false
            } isTargeted: { status in
                if let currentDragging, currentDragging.id != task.id, status {
                    withAnimation(.spring()) {
                        switch task.status {
                        case .todo:
                            replaceItem(tasks: &todo, droppingTask: task, status: .todo)
                        case .working:
                            replaceItem(tasks: &, droppingTask: <#T##Task#>, status: <#T##Status#>)
                        }
                    }
                }
            }

    }
    
    func replaceItem(tasks: inout [Task], droppingTask: Task, status: Status) {
        if let currentDragging {
            if let sourceIndex = tasks.firstIndex(where: { $0.id == currentDragging.id }),
               let destinationIndex = tasks.firstIndex(where: { $0.id == droppingTask.id }) {
                var sourceTask = tasks.remove(at: sourceIndex)
                sourceTask.status = status
                tasks.insert(sourceTask, at: destinationIndex)
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {    
    static var previews: some View {
        TaskView(tasks: [], currentDragging: .constant(nil))
    }
}
