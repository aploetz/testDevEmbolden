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
