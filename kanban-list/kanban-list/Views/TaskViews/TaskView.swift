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
                        moveTaskAcrossList(status: task.status)
                        
                        switch task.status {
                        case .todo:
                            moveTaskInSameList(tasks: &appData.todo, droppingTask: task, status: .todo)
                        case .working:
                            moveTaskInSameList(tasks: &appData.working, droppingTask: task, status: .working)
                        case .completed:
                            moveTaskInSameList(tasks: &appData.completed, droppingTask: task, status: .completed)
                        }
                    }
                }
            }

    }
    
    func moveTaskInSameList(tasks: inout [Task], droppingTask: Task, status: Status) {
        if let currentDragging = appData.currentDragging {
            if let sourceIndex = tasks.firstIndex(where: { $0.id == currentDragging.id }),
               let destinationIndex = tasks.firstIndex(where: { $0.id == droppingTask.id }) {
                var sourceTask = tasks.remove(at: sourceIndex)
                sourceTask.status = status
                tasks.insert(sourceTask, at: destinationIndex)
            }
        }
    }
    
    func moveTaskAcrossList(status: Status) {
        if let currentDragging = appData.currentDragging {
            switch status {
            case .todo:
                if !appData.todo.contains(where: { $0.id == currentDragging.id }) {
                    var updatedTask = currentDragging
                    // 할 일 상태를 수정하고
                    updatedTask.status = .todo
                    // 목록에 해당 할 일을 추가하고
                    appData.todo.append(updatedTask)
                    // 나머지 목록에 동일한 할 일이 있으면 삭제하기
                    appData.working.removeAll(where: { $0.id == updatedTask.id })
                    appData.completed.removeAll(where: { $0.id == updatedTask.id })
                }
            case .working:
                if !appData.working.contains(where: { $0.id == currentDragging.id }) {
                    var updatedTask = currentDragging
                    // 할 일 상태를 수정하고
                    updatedTask.status = .working
                    // 목록에 해당 할 일을 추가하고
                    appData.working.append(updatedTask)
                    // 나머지 목록에 동일한 할 일이 있으면 삭제하기
                    appData.todo.removeAll(where: { $0.id == updatedTask.id })
                    appData.completed.removeAll(where: { $0.id == updatedTask.id })
                }
            case .completed:
                if !appData.completed.contains(where: { $0.id == currentDragging.id }) {
                    var updatedTask = currentDragging
                    // 할 일 상태를 수정하고
                    updatedTask.status = .completed
                    // 목록에 해당 할 일을 추가하고
                    appData.completed.append(updatedTask)
                    // 나머지 목록에 동일한 할 일이 있으면 삭제하기
                    appData.todo.removeAll(where: { $0.id == updatedTask.id })
                    appData.working.removeAll(where: { $0.id == updatedTask.id })
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
