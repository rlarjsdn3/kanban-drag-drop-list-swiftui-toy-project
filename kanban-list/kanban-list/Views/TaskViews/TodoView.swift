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
            // 상호작용이 가능한 영역을 지정합니다.
            .contentShape(Rectangle())
            // 스크롤 뷰 영역에 드롭 동작이 일어나면 '할 일'이 목록을 옮깁니다.
            // 아래 제어자가 필요한 이유는 빈 목록으로 '할 일'을 드롭할 수 있게 하기 위함입니다.
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
            .environmentObject(ApplicationData())
    }
}
