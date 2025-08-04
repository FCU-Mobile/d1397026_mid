//
//  LibraryViewModel.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//

import Foundation  // 導入Foundation框架，提供基礎數據類型和功能支持
import SwiftUI  // 導入SwiftUI框架，用於UI數據綁定功能
import Observation  // 導入Observation框架，提供@Observable宏支持

// LibraryViewModel類負責管理圖書館應用的業務邏輯和數據狀態
// 採用MVVM設計模式，將視圖邏輯與UI表示層分離，提高代碼可維護性和可測試性
@Observable  // 使用@Observable宏替代ObservableObject，這是iOS 17引入的新數據管理方式
class LibraryViewModel {  // 不再需要繼承ObservableObject
    var searchTerm: String = ""  // 用戶輸入的搜索詞，不再需要@Published標記
    var selectedCategory: Int? = nil  // 當前選中的分類ID，可選類型表示可以不選擇任何分類（即顯示全部）
    var books: [Book] = []  // 書籍數據集合，根據搜索結果和分類篩選會動態變化
    var categories: [Category] = []  // 所有可用的圖書分類列表
    var isLoggedIn: Bool = false  // 用戶登錄狀態，控制是否顯示需要權限的功能

    init() {  // 初始化方法，設置初始數據
        // 建立分類數據，在實際應用中這些數據通常會從服務器或本地數據庫獲取
        categories = [
            Category(id: 1, title: "心理勵志"),  // 創建不同的書籍分類
            Category(id: 2, title: "文學小說"),  // 每個分類有唯一ID和顯示標題
            Category(id: 3, title: "漫畫"),  // 分類列表用於側邊欄顯示和書籍篩選
            Category(id: 4, title: "程式設計"),  // 提供多樣化的分類以滿足不同用戶需求
        ]
        
        // 建立示例書籍數據，實際應用中這些數據會從服務器或資料庫獲取
        books = [
            // 每本書都有完整的屬性集，包括可用數量和總數量以反映館藏狀態
            Book(id: 1, title: "世界盡頭的咖啡館", author: "John", category: "心理勵志", publisher: "獨步文化", publishYear: "2020", imageUrl: nil, availableCopies: 2, totalCopies: 5),  // 心理勵志類書籍示例
            Book(id: 2, title: "Java SE 17 技術手冊", author: "林信良", category: "程式", publisher: "碁峰", publishYear: "2022", imageUrl: nil, availableCopies: 1, totalCopies: 3),  // 程式設計類書籍示例
            Book(id: 3, title: "鏈鋸人", author: "藤本タツキ", category: "漫畫", publisher: "東立", publishYear: "2021", imageUrl: nil, availableCopies: 1, totalCopies: 3),  // 漫畫類書籍示例
            Book(id: 4, title: "GOTH 斷掌事件", author: "乙一", category: "文學小說", publisher: "皇冠文化", publishYear: "2015", imageUrl: "https://www.mottainaihonpo.com/kaitori/contents/cat01/img/otsuichi-osusume-img/book_04.jpg", availableCopies: 1, totalCopies: 3)  // 文學小說類書籍示例
        ]
    }
    
    // 執行搜索操作的方法，將根據searchTerm過濾書籍
    func performSearch() {
        // 搜尋邏輯（未實作）
        // 此處將來可實現根據標題、作者或其他字段過濾書籍的功能
        // 目前為空實現，表示這是計劃中但尚未完成的功能
    }
    
    // 登出功能，重置用戶登錄狀態
    func logout() {
        isLoggedIn = false  // 將登錄狀態設為false，會影響UI顯示相關權限功能
    }
    
    // 登入功能，設置用戶為已登錄狀態
    func login() {
        isLoggedIn = true  // 將登錄狀態設為true，啟用需要用戶登錄的功能
        // 在實際應用中，這裡還會包含用戶認證邏輯和獲取用戶信息的代碼
    }
}
