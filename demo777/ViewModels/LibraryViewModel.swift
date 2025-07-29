//
//  LibraryViewModel.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//

import Foundation
import SwiftUI

class LibraryViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var selectedCategory: Int? = nil
    @Published var books: [Book] = []
    @Published var categories: [Category] = []
    @Published var isLoggedIn: Bool = false
    
    init() {
        categories = [
            Category(id: 1, title: "小說"),
            Category(id: 2, title: "科學"),
            Category(id: 3, title: "歷史")
        ]
        
        books = [
            Book(id: 1, title: "星際穿越", author: "作者A", category: "小說", publisher: "出版社A", publishYear: 2020, imageUrl: nil, availableCopies: 2, totalCopies: 5),
            Book(id: 2, title: "宇宙探秘", author: "作者B", category: "科學", publisher: "出版社B", publishYear: 2021, imageUrl: nil, availableCopies: 1, totalCopies: 3)
        ]
    }
    
    func performSearch() {
        // 搜尋邏輯（未實作）
    }
    
    func logout() {
        isLoggedIn = false
    }
    
    func login() {
        isLoggedIn = true
    }
}
