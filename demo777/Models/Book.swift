//
//  Book.swift
//  demo777
//
//  Created by 訪客使用者 on 2025/7/29.
//
import Foundation

struct Book: Identifiable {
    let id: Int
    let title: String
    let author: String
    let category: String
    let publisher: String
    let publishYear: String
    let imageUrl: String?
    let availableCopies: Int
    let totalCopies: Int
}
