//
//  LibraryMainView.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//

import SwiftUI

struct LibraryMainView: View {
    @StateObject private var vm = LibraryViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 上方欄位（標題與搜尋）
                VStack(alignment: .leading, spacing: 12) {
                    Text("日比野線上圖書館")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    HStack {
                        TextField("輸入關鍵字", text: $vm.searchTerm)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onSubmit {
                                vm.performSearch()
                            }

                        Button(action: vm.performSearch) {
                            Label("搜尋", systemImage: "magnifyingglass")
                        }
                        .padding(.horizontal)
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.indigo)

                // 主體區域
                HStack(alignment: .top) {
                    // 分類欄
                    VStack(alignment: .leading, spacing: 8) {
                        Button("所有書籍") {
                            vm.selectedCategory = nil
                        }
                        .foregroundColor(vm.selectedCategory == nil ? .blue : .primary)

                        ForEach(vm.categories) { category in
                            Button(category.title) {
                                vm.selectedCategory = category.id
                            }
                            .foregroundColor(vm.selectedCategory == category.id ? .blue : .primary)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .frame(minWidth: 120)

                    // 書籍區塊
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(vm.books) { book in
                                BookCardView(book: book)
                            }
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarHidden(true)
        }
    }
}
