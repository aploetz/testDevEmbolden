//
//  Crystals.swift
//  testDevCrystals
//
//  Created by Aaron Ploetz on 6/23/24.
//

import Foundation

struct CrystalResponse: Decodable {
    let results: [Crystal]
}

struct Crystal: Decodable {
    var name: String
    var image_name: String
    var chakra: [String]
    var physical_attributes: String
    var emotional_attributes: String
    var metaphysical_attributes: String
    var origin: String
    var birth_month: String
    var zodiac_sign: String
    var maximum_mohs_hardness: Float
    var minimum_mohs_hardness: Float
}

extension Crystal {
    static let sampleData: [Crystal] =
    [
        Crystal(name: "Agate Druzy",
                image_name: "agate_druzy.png",
                chakra: ["Crown","Root"],
                physical_attributes: "Immune system, brain",
                emotional_attributes: "Instills positivity, amplifies body's natural healing",
                metaphysical_attributes: "Aids in meditation, enhances spiritual growth",
                origin: "Brazil, Uruguay, Mexico",
                birth_month: "July",
                zodiac_sign: "Cancer",
                maximum_mohs_hardness: 7.0,
                minimum_mohs_hardness: 6.5)
    ]
}
