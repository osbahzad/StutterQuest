//
//  PronunciationService.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/30/24.
// help with AI

import Foundation

struct Phonetic: Decodable {
    let text: String?
    let audio: String?
}

struct Result: Decodable {
    let word: String
    let phonetics: [Phonetic]?
}

class PronunciationService {
    func fetchPronunciation(for word: String) async -> String? {
        let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let results = try JSONDecoder().decode([Result].self, from: data)
            return results.first?.phonetics?.first(where: { $0.audio != nil })?.audio
        } catch {
            print("Error fetching pronunciation: \(error)")
            return nil
        }
    }
}


