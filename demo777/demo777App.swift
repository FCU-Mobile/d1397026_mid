//
//  demo777App.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/22.
//

import SwiftUI  // 引入SwiftUI框架，提供UI構建的所有必要元件和功能

@main  // 標記這個結構為應用程式的入口點，SwiftUI應用程式需要一個被@main標記的結構來啟動
struct demo777App: App {  // 定義一個遵循App協議的結構，這是SwiftUI應用程式的主要容器
    var body: some Scene {  // 實作App協議所需的body屬性，返回一個Scene類型
        WindowGroup {  // 創建一個WindowGroup場景，這是最常用的場景類型，用於管理應用程式的主視窗
//            ContentView()  // 被註釋掉的原始主視圖，表明應用程式曾經使用ContentView作為主視圖
            LibraryMainView()  // 設置LibraryMainView作為應用程式的主視圖，這是一個圖書館應用的主界面
            // 使用LibraryMainView而非ContentView表明應用已經從初始版本演進，現在專注於圖書館功能
        }
    }
}

#Preview {  // 定義一個SwiftUI預覽，方便在Xcode的畫布中查看視圖的外觀，不影響實際運行
    LibraryMainView()  // 指定預覽LibraryMainView，使設計過程中可以直接看到界面效果
}
