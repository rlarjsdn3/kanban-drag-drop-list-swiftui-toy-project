//
//  TaskView.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

struct TaskView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    @EnvironmentObject var appData: ApplicationData
    
    // MARK: - PROPERTIES
    
    var tasks: [Task]
    
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
            .frame(width: size.width, height: size.height, alignment: .leading)
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
                        appData.currentDragging = task
                    }
            }
            .dropDestination(for: String.self) { items, location in
                // 드래그가 끝난 후(터치를 떼면) 실행되는 클로저
                appData.currentDragging = nil
                return false
            } isTargeted: { status in
                // 드래그가 일어나는 동안 실행되는 클로저
                // 해당 지점에 드롭이 가능하면 status가 true가 된다
                if let currentDragging = appData.currentDragging, currentDragging.id != task.id, status {
                    withAnimation(.spring()) {
                        appData.moveTaskAcrossList(task.status)
                        
                        appData.moveTaskInSameList(task.status, droppingTask: task)
                    }
                }
            }

    }
}

struct TaskView_Previews: PreviewProvider {    
    static var previews: some View {
        TaskView(tasks: [])
            .environmentObject(ApplicationData())
    }
}
