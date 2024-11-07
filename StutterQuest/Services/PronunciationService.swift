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
            
            // Iterate through each result's phonetics to find the first available audio URL
            for result in results {
                if let phonetics = result.phonetics {
                    for phonetic in phonetics {
                        if let audioURL = phonetic.audio, !audioURL.isEmpty {
                            print("Found audio URL for '\(word)': \(audioURL)")
                            return audioURL // Stop and return the first valid audio URL
                        }
                    }
                }
            }
            
            print("No audio URL available for '\(word)'")
            return nil // No audio URL found in any of the phonetics

        } catch {
            print("Error fetching pronunciation: \(error)")
            return nil
        }
    }
}

