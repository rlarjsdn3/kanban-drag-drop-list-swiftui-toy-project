//
//  ContentView.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    // 샘플 작업 목록을 저장한 State 래퍼변수
    @State private var todo: [Task] = [
        Task(title: "문어 이뻐해주기", status: .todo)
    ]
    @State private var working: [Task] = [
        Task(title: "깃&깃허브 공부하기", status: .working),
        Task(title: "부크부크 앱 업데이트하기", status: .working)
    ]
    @State private var completed: [Task] = [
        Task(title: "이마트가서 장 봐오기", status: .completed),
        Task(title: "애플 아카데미 지원하기", status: .completed)
    ]
    
    // 현재 드래그한 목록을 저장한 State 래퍼변수
    @State private var currentDragging: Task?
    
    // MARK: - BODY
    
    var body: some View {
        HStack(spacing: 2) {
            TodoView(todo: $todo, currentDragging: $currentDragging)
            
            WorkingView(working: $working, currentDragging: $currentDragging)
            
            CompletedView(completed: $completed, currentDragging: $currentDragging)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
