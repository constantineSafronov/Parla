//
//  WordSetDTO.swift
//  Parla
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import Foundation

struct WordSetDTO: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let emoji: String
}
