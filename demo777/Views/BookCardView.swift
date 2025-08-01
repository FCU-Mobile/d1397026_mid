//
//  BookCardView.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//

import SwiftUI  // 導入SwiftUI框架，提供構建UI所需的所有組件和功能

// BookCardView是一個可重用的視圖組件，負責顯示單本書籍的卡片式詳情
// 採用卡片設計提高視覺吸引力並清晰區分不同書籍
struct BookCardView: View {
    let book: Book  // 接收一個Book模型實例，包含要顯示的書籍信息
    @State private var showDetail = false  // 控制是否顯示詳情頁的狀態
    @Namespace private var animation  // 創建命名空間用於匹配動畫效果

    // 視圖主體，定義UI佈局和外觀
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {  // 垂直排列的容器，左對齊，元素間距8點
            HStack(alignment: .top, spacing: 16) {  // 水平排列的容器，頂部對齊，元素間距16點
                Rectangle()  // 創建一個矩形作為書籍封面的佔位符
                    .fill(Color.gray.opacity(0.3))  // 設置淺灰色填充，透明度0.3使其看起來柔和
                    .frame(width: 96, height: 128)  // 設置固定寬高比例，模擬書籍封面尺寸
                    .matchedGeometryEffect(id: "bookImage\(book.id)", in: animation)  // 添加匹配效果用於動畫
                    .overlay(  // 在矩形上添加覆蓋層
                        Text("無圖片")  // 當無圖片時顯示的提示文字
                            .foregroundColor(.gray)  // 設置文字為灰色，與背景區分但不突兀
                    )  // 此佔位符在實際應用中將被替換為從imageUrl加載的真實書籍封面

                VStack(alignment: .leading, spacing: 4) {  // 垂直排列的容器，左對齊，元素間距4點，包含書籍詳情
                    Text(book.title)  // 顯示書籍標題
                        .font(.headline)  // 使用標題字體強調書名的重要性
                        .matchedGeometryEffect(id: "title\(book.id)", in: animation)  // 添加匹配效果用於動畫
                    Text("作者: \(book.author)")  // 顯示作者信息，格式化為"作者: 作者名"
                    Text("分類: \(book.category)")  // 顯示分類信息，幫助用戶快速識別書籍類型
                    Text("出版商: \(book.publisher) (\(book.publishYear))")  // 顯示出版信息，包括出版商和年份
                    Text("可借閱: \(book.availableCopies) / 總數: \(book.totalCopies)")  // 顯示館藏數量信息
                        .fontWeight(.semibold)  // 半粗體突顯可用性信息的重要性
                        .foregroundColor(.indigo)  // 使用靛藍色突出顯示，與應用的主題色調一致
                }
            }

            HStack {  // 水平排列容器，用於放置操作按鈕
                Spacer()  // 彈性空間，將按鈕推到右側對齊

                // 使用NavigationLink替代原來的Button+sheet，添加動畫效果
                NavigationLink(
                    destination: BookDetailView(book: book, namespace: animation, show: $showDetail),
                    isActive: $showDetail
                ) {
                    Text("查看詳情")
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                }
                .buttonStyle(ScaleButtonStyle())  // 添加自定義的按鈕縮放效果
            }
        }
        .padding()  // 為整個卡片添加內邊距，與其他內容保持適當間距
        .background(Color.white)  // 設置卡片背景為白色，與應用的淺色主題匹配
        .cornerRadius(12)  // 設置較大的圓角，使卡片外觀更柔和現代
        .shadow(color: Color.black.opacity(0.1), radius: 4)  // 添加輕微陰影，提高卡片的立體感和層次感
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showDetail = true
            }
        }
    }
}

// 自定義按鈕樣式，添加縮放效果
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// 新增一個BookDetailView來顯示書籍詳情
struct BookDetailView: View {
    let book: Book
    var namespace: Namespace.ID
    @Binding var show: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 書籍封面圖片
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .matchedGeometryEffect(id: "bookImage\(book.id)", in: namespace)
                    .overlay(
                        Text("書籍封面")
                            .foregroundColor(.gray)
                    )

                // 書籍詳細信息
                Group {
                    Text(book.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "title\(book.id)", in: namespace)

                    Text("作者: \(book.author)")
                        .font(.headline)
                        .opacity(show ? 1 : 0)
                        .animation(.easeInOut.delay(0.2), value: show)

                    Text("分類: \(book.category)")
                        .opacity(show ? 1 : 0)
                        .animation(.easeInOut.delay(0.3), value: show)

                    Text("出版商: \(book.publisher)")
                        .opacity(show ? 1 : 0)
                        .animation(.easeInOut.delay(0.4), value: show)

                    Text("出版年份: \(book.publishYear)")
                        .opacity(show ? 1 : 0)
                        .animation(.easeInOut.delay(0.5), value: show)

                    Text("可借閱數量: \(book.availableCopies)")
                        .opacity(show ? 1 : 0)
                        .animation(.easeInOut.delay(0.6), value: show)

                    Text("總數量: \(book.totalCopies)")
                        .opacity(show ? 1 : 0)
                        .animation(.easeInOut.delay(0.7), value: show)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationTitle(book.title)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.indigo)
                .imageScale(.large)
                .padding()
                .background(Color.white.opacity(0.8))
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.1), radius: 2)
        })
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show = true
            }
        }
    }
}

#Preview {  // 定義SwiftUI預覽，方便在Xcode中實時查看組件外觀
    BookCardView(book: Book(  // 創建一個測試用的Book實例
        id: 999,  // 測試ID
        title: "測試書籍",  // 測試標題
        author: "測試作者",  // 測試作者
        category: "小說",  // 測試分類
        publisher: "測試出版社",  // 測試出版商
        publishYear: "2023",  // 測試出版年份
        imageUrl: nil,  // 無測試圖片
        availableCopies: 3,  // 測試可借閱數量
        totalCopies: 10  // 測試總數量
    ))
}
