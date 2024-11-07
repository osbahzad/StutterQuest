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
        let spokenWordsSet = Set(spokenText.lowercased().split(separator: " ").map { $0.trimmingCharacters(in: .punctuationCharacters) })
        let targetWords = targetText.split(separator: " ")

        var result: [ColorizedWord] = []

        for word in targetWords {
            let strippedWord = word.filter { $0.isLetter || $0.isNumber }
            
            // Determine the color based on whether the word has been spoken
            let color: Color = {
                if spokenWordsSet.isEmpty {
                    return .black // Default color if speech hasn't started
                } else if spokenWordsSet.contains(strippedWord.lowercased()) {
                    return .green // Word has been spoken
                } else {
                    return .red // Word has not been spoken
                }
            }()
            
            result.append(ColorizedWord(text: String(word), strippedText: strippedWord, color: color))
        }

        return result
    }
}
