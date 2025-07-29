//
//  BookCardView.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//

import SwiftUI

struct BookCardView: View {
    let book: Book
    @State private var isShowing = false

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 16) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 96, height: 128)
                    .overlay(
                        Text("無圖片")
                            .foregroundColor(.gray)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(book.title)
                        .font(.headline)
                    Text("作者: \(book.author)")
                    Text("分類: \(book.category)")
                    Text("出版商: \(book.publisher) (\(book.publishYear))")
                    Text("可借閱: \(book.availableCopies) / 總數: \(book.totalCopies)")
                        .fontWeight(.semibold)
                        .foregroundColor(.indigo)
                }
            }

            HStack {
                Spacer()
                /*Button("查看詳情") {
                    // 尚未實作
                }*/
                Button {
                    isShowing = true
                } label: {
                    Text("查看詳情")
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(Color.indigo)
                .foregroundColor(.white)
                .cornerRadius(6)
            }
            .sheet(isPresented: $isShowing) {
                Text("這是一本書")
                    .presentationDetents([.large, .fraction(0.33)])
                    .presentationDragIndicator(.visible)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4)
    }
}


#Preview {
    BookCardView(book: Book(
        id: 999,
        title: "測試書籍",
        author: "測試作者",
        category: "小說",
        publisher: "測試出版社",
        publishYear: 2023,
        imageUrl: nil,
        availableCopies: 3,
        totalCopies: 10
    ))
}
