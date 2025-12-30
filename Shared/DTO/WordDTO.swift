//
//  WordDTO.swift
//  Parla
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import Foundation

struct WordDTO: Identifiable, Codable, Hashable {
    var id: UUID
    let value: String
    let translation: String
    let setId: UUID
}
