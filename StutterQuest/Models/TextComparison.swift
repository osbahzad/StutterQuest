//
//  TextComparison.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/30/24.
// Help with AI


import Foundation
import SwiftUI

struct ColorizedWord: Identifiable, Hashable {
    let id = UUID()
    let text: String // Text to be displayed (with punctuation)
    let strippedText: String // Text stripped of punctuation
    let color: Color
}

struct TextComparison {
    static func colorizeText(spokenText: String, targetText: String) -> [ColorizedWord] {
        let spokenWords = spokenText.split(separator: " ")
        let targetWords = targetText.split(separator: " ")

        var result: [ColorizedWord] = []

        for (index, word) in targetWords.enumerated() {
            // Strip punctuation for comparison purposes
            let strippedWord = word.filter { $0.isLetter || $0.isNumber }
            let color: Color = {
                if index < spokenWords.count {
                    return spokenWords[index].lowercased() == strippedWord.lowercased() ? .green : .red
                } else {
                    return .black
                }
            }()
            
            result.append(ColorizedWord(text: String(word), strippedText: String(strippedWord), color: color))
        }

        return result
    }
}




//import Foundation
//import SwiftUI
//
//struct ColorizedWord: Identifiable, Hashable {
//    let id = UUID()
//    let text: String
//    let color: Color
//}
//
//
//struct TextComparison {
//    static func colorizeText(spokenText: String, targetText: String) -> [ColorizedWord] {
//        let spokenWords = spokenText.split(separator: " ")
//        let targetWords = targetText.split(separator: " ")
//
//        var result: [ColorizedWord] = []
//        for (index, word) in targetWords.enumerated() {
//            let color: Color = {
//                if index < spokenWords.count {
//                    return spokenWords[index].lowercased() == word.lowercased() ? .green : .red
//                } else {
//                    return .black
//                }
//            }()
//            result.append(ColorizedWord(text: String(word), color: color))
//        }
//        return result
//    }
//}

