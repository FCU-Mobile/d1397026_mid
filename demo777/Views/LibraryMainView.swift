//
//  LibraryMainView.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//

import SwiftUI

struct LibraryMainView: View {
    @StateObject private var vm = LibraryViewModel()
    @State private var showCategoryMenu: Bool = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                // 主畫面內容
                VStack(spacing: 0) {
                    // 頂部欄位
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            // 三條線按鈕（顯示分類欄）
                            Button(action: {
                                withAnimation {
                                    showCategoryMenu.toggle()
                                }
                            }) {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundColor(.white)
                                    .imageScale(.large)
                            }

                            Spacer()

                            Text("日比野線上圖書館")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }

                        // 搜尋欄
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

                    // 書籍區塊（可右滑開啟分類欄）
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(vm.books) { book in
                                BookCardView(book: book)
                            }
                        }
                        .padding()
                    }
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width > 100 {
                                    withAnimation {
                                        showCategoryMenu = true
                                    }
                                }
                            }
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                // 側邊分類欄（滑出式）
                if showCategoryMenu {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showCategoryMenu = false
                            }
                        }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Button("所有書籍") {
                        vm.selectedCategory = nil
                        withAnimation { showCategoryMenu = false }
                    }
                    .foregroundColor(vm.selectedCategory == nil ? .blue : .primary)

                    ForEach(vm.categories) { category in
                        Button(category.title) {
                            vm.selectedCategory = category.id
                            withAnimation { showCategoryMenu = false }
                        }
                        .foregroundColor(vm.selectedCategory == category.id ? .blue : .primary)
                    }

                    Spacer()
                }
                .padding()
                .frame(width: 220)
                .background(Color(.systemGray6))
                .offset(x: showCategoryMenu ? 0 : -240)
                .animation(.easeInOut(duration: 0.25), value: showCategoryMenu)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LibraryMainView()
}
