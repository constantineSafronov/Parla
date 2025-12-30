//
//  SharedDataManager.swift
//  Parla
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import Foundation

struct SharedDataManager {
  static let shared = SharedDataManager()
  
  private let groupIdentifier = "group.aero.parla.shared"
  private var defaults: UserDefaults?
  
  init() {
    defaults = UserDefaults(suiteName: groupIdentifier)
        
        // Получаем ВСЕ данные из defaults
    guard let allData = defaults?.dictionaryRepresentation() else { return }
        print("=== ВСЕ КЛЮЧИ в App Group ===")
        for key in allData.keys {
            print("Ключ: \(key)")
            if let data = defaults?.data(forKey: key) {
                print("  Размер данных: \(data.count) байт")
            }
        }
        
        // Проверьте конкретно ключи "sets" и "words"
        if let setsData = defaults?.data(forKey: "sets") {
            print("✅ sets найден, размер: \(setsData.count) байт")
        } else {
            print("❌ sets не найден")
        }
        
        if let wordsData = defaults?.data(forKey: "words") {
            print("✅ words найден, размер: \(wordsData.count) байт")
        } else {
            print("❌ words не найден")
        }
  }
  
//  func saveSets(_ sets: [WordSetDTO], words: [WordDTO]) {
//    guard let defaults = defaults else { return }
//    
//    if let setsData = try? JSONEncoder().encode(sets),
//       let wordsData = try? JSONEncoder().encode(words) {
//      defaults.set(setsData, forKey: "sets")
//      defaults.set(wordsData, forKey: "words")
//      defaults.synchronize()
//      print("Данные сохранены в App Group")
//    }
//  }
  
  func saveSets(_ sets: [WordSetDTO], words: [WordDTO]) {
      print("=== iPhone сохраняет данные ===")
      print("App Group ID: \(groupIdentifier)")
      
      // 1. Проверяем defaults
      guard let defaults = defaults else {
          print("❌ defaults на iPhone = nil")
          return
      }
      
      print("✅ defaults создан: \(defaults)")
      
      // 2. Проверяем что сохраняем
      print("Сохраняем \(sets.count) наборов, \(words.count) слов")
      
      // 3. Сохраняем и сразу проверяем
      if let setsData = try? JSONEncoder().encode(sets),
         let wordsData = try? JSONEncoder().encode(words) {
          defaults.set(setsData, forKey: "sets")
          defaults.set(wordsData, forKey: "words")
          defaults.synchronize()
          
          // 4. Проверяем что записалось
          let savedSetsData = defaults.data(forKey: "sets")
          let savedWordsData = defaults.data(forKey: "words")
          
          print("✅ Записано sets: \(savedSetsData?.count ?? 0) байт")
          print("✅ Записано words: \(savedWordsData?.count ?? 0) байт")
          
          // 5. Показываем ВСЕ ключи
          let allKeys = defaults.dictionaryRepresentation().keys
          print("=== Все ключи в App Group на iPhone ===")
          for key in allKeys {
              print("Ключ: \(key)")
          }
      }
  }
  
  func loadSets() -> ([WordSetDTO], [WordDTO]) {
    guard let defaults = defaults else { return ([], []) }
    
    let sets = (try? JSONDecoder().decode([WordSetDTO].self,
                                          from: defaults.data(forKey: "sets") ?? Data())) ?? []
    let words = (try? JSONDecoder().decode([WordDTO].self,
                                           from: defaults.data(forKey: "words") ?? Data())) ?? []
    
    print("Загружено: \(sets.count) наборов, \(words.count) слов")
    let uuid = UUID()
    return ([WordSetDTO(id: uuid, title: "Random", emoji: "✅") ],
            [WordDTO(id: UUID(), value: "Amore", translation: "Love", setId: uuid),
             WordDTO(id: UUID(), value: "Rilasarsi", translation: "Take Rest", setId: uuid)])
  }
}
