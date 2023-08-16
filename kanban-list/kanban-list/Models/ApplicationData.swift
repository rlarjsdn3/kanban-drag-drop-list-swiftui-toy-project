//
//  ApplicationData.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import Foundation

class ApplicationData: ObservableObject {
    
    // 샘플 작업 목록을 저장한 State 래퍼변수
    @Published var todo: [Task] = [
        Task(title: "문어 이뻐해주기", status: .todo)
    ]
    @Published var working: [Task] = [
        Task(title: "깃&깃허브 공부하기", status: .working),
        Task(title: "부크부크 앱 업데이트하기", status: .working)
    ]
    @Published var completed: [Task] = [
        Task(title: "이마트가서 장 봐오기", status: .completed),
        Task(title: "애플 아카데미 지원하기", status: .completed)
    ]
    
    // 현재 드래그한 목록을 저장한 State 래퍼변수
    @Published var currentDragging: Task?
    
    // 같은 목록 내 순서를 바꾸는 메서드
    func moveTaskInSameList(_ status: Status, droppingTask: Task) {
        if currentDragging != nil {
            switch status {
            case .todo:
                moveTask(tasks: &todo, droppingTask: droppingTask)
            case .working:
                moveTask(tasks: &working, droppingTask: droppingTask)
            case .completed:
                moveTask(tasks: &completed, droppingTask: droppingTask)
            }
        }
    }
    
    func moveTask(tasks: inout [Task], droppingTask: Task) {
        if let sourceIndex = tasks.firstIndex(where: { $0.id == currentDragging?.id }),
           let destinationIndex = tasks.firstIndex(where: { $0.id == droppingTask.id }) {
            let sourceTask = tasks.remove(at: sourceIndex)
            tasks.insert(sourceTask, at: destinationIndex)
        }
    }
    
    // 다른 목록으로 할 일을 옮기는 메서드
    func moveTaskAcrossList(_ status: Status) {
        if let currentDragging = currentDragging {
            switch status {
            case .todo:
                if !todo.contains(where: { $0.id == currentDragging.id }) {
                    var updatedTask = currentDragging
                    // 할 일 상태를 수정하고
                    updatedTask.status = .todo
                    // 목록에 해당 할 일을 추가하고
                    todo.append(updatedTask)
                    // 나머지 목록에 동일한 할 일이 있으면 삭제하기
                    working.removeAll(where: { $0.id == updatedTask.id })
                    completed.removeAll(where: { $0.id == updatedTask.id })
                }
            case .working:
                if !working.contains(where: { $0.id == currentDragging.id }) {
                    var updatedTask = currentDragging
                    // 할 일 상태를 수정하고
                    updatedTask.status = .working
                    // 목록에 해당 할 일을 추가하고
                    working.append(updatedTask)
                    // 나머지 목록에 동일한 할 일이 있으면 삭제하기
                    todo.removeAll(where: { $0.id == updatedTask.id })
                    completed.removeAll(where: { $0.id == updatedTask.id })
                }
            case .completed:
                if !completed.contains(where: { $0.id == currentDragging.id }) {
                    var updatedTask = currentDragging
                    // 할 일 상태를 수정하고
                    updatedTask.status = .completed
                    // 목록에 해당 할 일을 추가하고
                    completed.append(updatedTask)
                    // 나머지 목록에 동일한 할 일이 있으면 삭제하기
                    todo.removeAll(where: { $0.id == updatedTask.id })
                    working.removeAll(where: { $0.id == updatedTask.id })
                }
            }
        }
    }
}
