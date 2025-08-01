//
//  LibraryMainView.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
// searchable 已經幫你寫好，改天看看

import SwiftUI  // 引入SwiftUI框架，提供UI構建所需的所有組件和功能

// LibraryMainView是應用的主視圖，負責整合所有圖書館功能並提供用戶界面
// 此視圖實現了側滑選單、搜索功能和書籍列表顯示的完整圖書館體驗
struct LibraryMainView: View {
    @StateObject private var vm = LibraryViewModel()  // 創建ViewModel實例並標記為@StateObject，確保視圖生命週期內只創建一次
    @State private var showCategoryMenu: Bool = false  // 控制分類菜單顯示狀態的標誌，使用@State使其變化能觸發視圖重繪

    var body: some View {
        NavigationView {  // 使用NavigationView作為容器，提供導航功能的基礎架構
            ZStack(alignment: .leading) {  // 使用ZStack實現層疊佈局，設置左對齊便於側邊欄實現
                // 主畫面內容
                VStack(spacing: 0) {  // 垂直排列的主內容區，元素間無間距，確保視覺連貫性
                    // 頂部欄位 - 包含菜單按鈕、應用標題和搜索功能
                    VStack(alignment: .leading, spacing: 12) {  // 垂直排列頂部元素，左對齊，間距12點
                        HStack {  // 水平排列標題區元素
                            // 三條線按鈕（顯示分類欄）- 常見的漢堡選單圖標
                            Button(action: {  // 創建按鈕並定義點擊動作
                                withAnimation {  // 添加動畫效果，使側邊欄滑動更平滑
                                    showCategoryMenu.toggle()  // 切換側邊分類欄顯示狀態
                                }
                            }) {
                                Image(systemName: "line.3.horizontal")  // 使用系統提供的三條線圖標
                                    .foregroundColor(.white)  // 設置圖標顏色為白色，在深色背景上清晰可見
                                    .imageScale(.large)  // 放大圖標尺寸，提高可點擊面積和可見性
                            }

                            Spacer()  // 彈性空間，將左側菜單按鈕和右側標題分隔開

                            Text("線上圖書館")  // 應用標題文本
                                .font(.title)  // 使用標題級別的字體大小，突顯重要性
                                .fontWeight(.bold)  // 設置粗體強調標題
                                .foregroundColor(.white)  // 設置白色文本，在深色背景上清晰可見
                        }

                        // 搜尋欄 - 提供書籍搜索功能
                        HStack {  // 水平排列搜索欄元素
                            TextField("輸入關鍵字", text: $vm.searchTerm)  // 創建輸入框，綁定到ViewModel的searchTerm屬性
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 使用圓角邊框樣式，視覺上更現代
                                .onSubmit {  // 當用戶按下回車/提交時觸發
                                    vm.performSearch()  // 調用ViewModel的搜索方法執行搜索
                                }

                            Button(action: vm.performSearch) {  // 創建搜索按鈕，點擊時執行搜索
                                Label("搜尋", systemImage: "magnifyingglass")  // 使用系統放大鏡圖標和"搜尋"文本作為標籤
                            }
                            .padding(.horizontal)  // 水平方向內邊距，使按鈕更寬更易點擊
                            .background(Color.white.opacity(0.2))  // 半透明白色背景，與頂部欄協調但有區分
                            .foregroundColor(.white)  // 白色文本，在深色背景上清晰可見
                            .cornerRadius(8)  // 設置圓角半徑，視覺上更柔和現代
                        }
                    }
                    .padding()  // 為整個頂部區域添加內邊距，使元素不貼近屏幕邊緣
                    .background(Color.indigo)  // 設置靛藍色背景，作為應用的主題色

                    // 書籍區塊 - 顯示書籍列表，支持滑動手勢
                    ScrollView {  // 創建可滾動視圖，允許在有限空間內顯示大量書籍
                        LazyVStack(alignment: .leading, spacing: 16) {  // 使用LazyVStack優化性能，只渲染可見項
                            ForEach(vm.books) { book in  // 遍歷ViewModel中的所有書籍
                                BookCardView(book: book)  // 為每本書創建一個BookCardView實例顯示詳情
                            }
                        }
                        .padding()  // 為書籍列表添加內邊距，避免貼近屏幕邊緣
                    }
                    .gesture(  // 添加滑動手勢識別
                        DragGesture()  // 創建拖動手勢識別器
                            .onEnded { value in  // 當手勢結束時處理
                                if value.translation.width > 100 {  // 如果右滑距離超過100點
                                    withAnimation {  // 添加動畫效果
                                        showCategoryMenu = true  // 顯示側邊分類欄
                                    }
                                }
                            }
                    )  // 手勢支持使應用更符合移動設備的交互習慣
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)  // 設置主內容區填充整個可用空間

                // 側邊分類欄遮罩 - 當分類欄顯示時，添加半透明背景
                if showCategoryMenu {  // 條件渲染，僅當showCategoryMenu為true時顯示
                    Color.black.opacity(0.3)  // 創建半透明黑色遮罩，降低主內容區視覺優先級
                        .ignoresSafeArea()  // 忽略安全區，使遮罩覆蓋整個屏幕
                        .onTapGesture {  // 添加點擊手勢
                            withAnimation {  // 添加動畫效果
                                showCategoryMenu = false  // 點擊遮罩區域時隱藏分類欄
                            }
                        }
                }

                // 側邊分類欄主體 - 顯示所有可選分類
                VStack(alignment: .leading, spacing: 8) {  // 垂直排列分類選項，左對齊，間距8點
                    Button("所有書籍") {  // 創建"所有書籍"選項按鈕
                        vm.selectedCategory = nil  // 設置選中分類為nil，表示不過濾任何分類
                        withAnimation { showCategoryMenu = false }  // 選擇後隱藏分類欄
                    }
                    .foregroundColor(vm.selectedCategory == nil ? .blue : .primary)  // 當前選中項顯示藍色，其他顯示默認色

                    ForEach(vm.categories) { category in  // 遍歷所有分類
                        Button(category.title) {  // 創建分類按鈕，顯示分類名稱
                            vm.selectedCategory = category.id  // 設置選中的分類ID
                            withAnimation { showCategoryMenu = false }  // 選擇後隱藏分類欄
                        }
                        .foregroundColor(vm.selectedCategory == category.id ? .blue : .primary)  // 當前選中項顯示藍色，其他顯示默認色
                    }

                    Spacer()  // 彈性空間，確保分類選項靠近頂部顯示
                }
                .padding()  // 為分類欄添加內邊距
                .frame(width: 120)  // 設置固定寬度，確保視覺一致性
                .background(Color(.systemGray6))  // 設置淺灰色背景，與主內容區分
                .offset(x: showCategoryMenu ? 0 : -240)  // 根據showCategoryMenu狀態設置水平偏移，實現滑入滑出效果
                .animation(.easeInOut(duration: 0.25), value: showCategoryMenu)  // 添加緩入緩出動畫，持續0.25秒，使過渡更流暢
            }
            .navigationBarHidden(true)  // 隱藏默認導航欄，因為已經自定義了頂部欄
        }  // NavigationView結束
    }  // body屬性結束
}  // LibraryMainView結構結束

#Preview {  // 定義SwiftUI預覽，便於在開發過程中實時查看UI效果
    LibraryMainView()  // 預覽LibraryMainView的實例
}
