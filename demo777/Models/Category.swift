//
//  Category.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//

import Foundation  // 導入Foundation框架，提供基礎數據類型和功能支持

// Category結構代表書籍的分類信息，遵循Identifiable協議以便在列表和選擇器中唯一識別每個分類
struct Category: Identifiable {
    let id: Int  // 分類的唯一識別碼，用於在集合中區分不同分類，也用於與書籍的category字段關聯
    let title: String  // 分類的顯示名稱，用於在UI界面中顯示給用戶，如側邊欄的分類列表中
    // 使用常量(let)而非變量(var)是因為分類信息通常是靜態的，不需要在運行時修改
    // Identifiable協議讓SwiftUI可以更容易地處理分類集合，特別是在ForEach循環中
}
