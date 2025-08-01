//
//  Book.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//

import Foundation  // 導入Foundation框架，提供基礎數據類型和功能支持

// Book結構代表圖書館中的一本書籍，遵循Identifiable協議以便在列表中唯一識別每本書
struct Book: Identifiable {
    let id: Int  // 書籍的唯一識別碼，用於在集合中區分不同書籍，遵循Identifiable協議要求
    let title: String  // 書籍標題，是展示和搜索的主要信息
    let author: String  // 書籍作者，有助於用戶根據作者查找書籍
    let category: String  // 書籍分類，用於按類別組織和過濾書籍
    let publisher: String  // 出版商信息，提供書籍來源的額外資料
    let publishYear: String  // 出版年份，使用字符串類型以適應多種格式的年份表示
    let imageUrl: String?  // 書籍封面圖片URL，可選類型表示書籍可能沒有封面圖片
    let availableCopies: Int  // 當前可借閱的書籍數量，用於顯示書籍可用性
    let totalCopies: Int  // 館藏總數量，結合availableCopies可計算已借出數量
    // 所有屬性都設置為常量(let)，表示書籍信息一旦創建後不應被修改，確保數據一致性
}
