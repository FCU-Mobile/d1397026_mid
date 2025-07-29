//
//  ContentView.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/22.
//

import SwiftUI

struct CustomKeyboard: View {
    // 定義鍵盤佈局的二維陣列
    // 每一列代表鍵盤的一行
    let keyboardLayout: [[String]] = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Z", "X", "C", "V", "B", "N", "M"]
    ]
    
    // 特殊按鍵的定義
    let specialKeys = ["刪除", "空白鍵", "完成"]
    
    // 狀態變數：用來追蹤目前輸入的文字
    @State private var inputText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部文字輸入顯示區域
            VStack {
                Text("輸入文字：")
                    .font(.headline)
                    .padding(.top)
                
                // 顯示當前輸入的文字
                TextField("請輸入文字", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
            }
            .background(Color(UIColor.systemGray6))
            
            Spacer()
            
            // 鍵盤主體區域
            VStack(spacing: 8) {
                // 遍歷每一行鍵盤佈局
                ForEach(0..<keyboardLayout.count, id: \.self) { rowIndex in
                    HStack(spacing: 6) {
                        // 第三行（最後一行）需要特殊處理：添加刪除鍵
                        if rowIndex == 2 {
                            // 刪除鍵
                            KeyButton(text: "⌫", action: {
                                if !inputText.isEmpty {
                                    inputText.removeLast()
                                }
                            })
                            .frame(minWidth: calculateKeyWidth() * 1.3)
                        }
                        
                        // 生成該行的所有按鍵
                        ForEach(keyboardLayout[rowIndex], id: \.self) { key in
                            KeyButton(text: key, action: {
                                inputText += key
                            })
                            .frame(width: calculateKeyWidth())
                        }
                        
                        // 第三行添加確認鍵
                        if rowIndex == 2 {
                            KeyButton(text: "↵", action: {
                                // 這裡可以處理確認邏輯
                                print("確認輸入：\(inputText)")
                            })
                            .frame(minWidth: calculateKeyWidth() * 1.3)
                        }
                    }
                }
                
                // 最底部的特殊按鍵行
                HStack(spacing: 6) {
                    // 123 數字鍵
                    KeyButton(text: "123", action: {
                        // 這裡可以切換到數字鍵盤
                        print("切換到數字鍵盤")
                    })
                    .frame(width: calculateKeyWidth() * 1.2)
                    
                    // 空白鍵（佔據較大空間）
                    KeyButton(text: "空白", action: {
                        inputText += " "
                    })
                    .frame(width: calculateKeyWidth() * 6)
                    
                    // 完成按鍵
                    KeyButton(text: "完成", action: {
                        // 這裡可以處理完成邏輯
                        print("完成輸入")
                    })
                    .frame(width: calculateKeyWidth() * 1.2)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            .background(Color(UIColor.systemGray5))
        }
    }
    
    // 計算每個按鍵的寬度，根據螢幕寬度自適應
    private func calculateKeyWidth() -> CGFloat {
        // 取得螢幕寬度
        let screenWidth = UIScreen.main.bounds.width
        // 扣除左右邊距和按鍵間距，再除以一行最多的按鍵數量
        let padding: CGFloat = 20  // 左右邊距
        let spacing: CGFloat = 6 * 9  // 9個間距，每個6點
        let availableWidth = screenWidth - padding - spacing
        let keyWidth = availableWidth / 10  // 最多一行有10個按鍵
        
        return max(keyWidth, 30)  // 確保最小寬度為30點
    }
}

// 自定義按鍵元件
struct KeyButton: View {
    let text: String
    let action: () -> Void
    
    // 狀態變數：追蹤按鍵是否被按下12
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.primary)
                .frame(height: 44)  // 固定高度44點
                .frame(maxWidth: .infinity)  // 寬度填滿可用空間
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(isPressed ? Color(UIColor.systemGray3) : Color(UIColor.systemBackground))
                        .shadow(color: .gray.opacity(0.3), radius: 1, x: 0, y: 1)
                )
                .scaleEffect(isPressed ? 0.95 : 1.0)  // 按下時縮放效果
        }
        .buttonStyle(PlainButtonStyle())  // 移除默認按鈕樣式
        .onLongPressGesture(minimumDuration: 0, perform: {
            // 長按手勢，用於實現按下效果
        } ,onPressingChanged: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        })
    }
}

// 主要的內容視圖
struct ContentView: View {
    var body: some View {
        CustomKeyboard()
            .ignoresSafeArea(.keyboard)  // 忽略系統鍵盤的安全區域
    }
}

// 預覽用的程式碼
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            // 預覽不同尺寸的裝置
            .previewDevice("iPhone 14")
            .previewDisplayName("iPhone 14")
        
        ContentView()
            .previewDevice("iPhone SE (3rd generation)")
            .previewDisplayName("iPhone SE")
        
        ContentView()
            .previewDevice("iPad Pro (11-inch) (4th generation)")
            .previewDisplayName("iPad Pro")
    }
}

#Preview {
    ContentView()
}
