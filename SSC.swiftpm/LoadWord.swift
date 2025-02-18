//
//  LoadWord.swift
//  SSC
//
//  Created by Irfan on 17/02/25.
//

import Foundation
struct WordEntry: Identifiable, Codable {
    var id: Int { serial }  // Conforming to Identifiable using serial
    let word: String
    let definition: String
    let category: String
    let level: String
    let serial: Int
}

func loadPredefinedData() -> [WordEntry] {
    guard let url = Bundle.main.url(forResource: "restaurant_food_vocabulary", withExtension: "json") else {
        print("Failed to locate file in bundle.")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let wordEntries = try decoder.decode([WordEntry].self, from: data)
        print("Loaded word entries: \(wordEntries)") // Debug line
        return wordEntries
    } catch {
        print("Error loading or decoding JSON data: \(error)")
        return []
    }
}

