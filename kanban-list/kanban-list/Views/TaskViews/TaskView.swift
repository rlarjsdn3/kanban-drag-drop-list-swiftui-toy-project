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
            // 각 할 일 목록 셀로만 드롭 동작이 가능합니다.
            // 따라서, 할 일 목록이 비어있을 때는 그 목록으로 드롭이 되지 않습니다. (자세한 내용은 각 하위 뷰 참조)
            .dropDestination(for: String.self) { items, location in
                // items 매개변수는 String타입의 배열이 전달됩니다.
                // 이때, 배열로 전달되는 이유는 여러 셀이 한꺼번에 선택될 수 있기 때문입니다.
                
                // location 매개변수는 CGPoint타입의 위치 정보가 전달됩니다.
                
                // 드래그 앤 드롭 동작이 끝나면 호출되는 클로저로
                // 동작에 성공했다면 true를, 실패했다면 false를 반환합니다.
                appData.currentDragging = nil
                return false
            } isTargeted: { status in
                // 드래그 동작을 하는 동안 실행되는 클로저로
                // 드롭이 가능한 지점으로 드래그를 하면 status가 true로, 그게 아니라면 false가 전달됩니다.
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
