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
}
